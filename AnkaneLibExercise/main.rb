
# ported from PyTorch Examples
# https://github.com/pytorch/examples/blob/master/mnist/main.py
# Copyright (c) 2017 PyTorch contributors, 2019 Andrew Kane
# BSD 3-Clause License

require "torch"
require "npy"

class Net < Torch::NN::Module
  def initialize
    super
    @conv1 = Torch::NN::Conv2d.new(1, 32, 3, stride: 1)
    @conv2 = Torch::NN::Conv2d.new(32, 64, 3, stride: 1)
    @dropout1 = Torch::NN::Dropout2d.new(p: 0.25)
    @dropout2 = Torch::NN::Dropout2d.new(p: 0.5)
    @fc1 = Torch::NN::Linear.new(9216, 128)
    @fc2 = Torch::NN::Linear.new(128, 10)
  end

  def forward(x)
    x = @conv1.call(x)
    x = Torch::NN::F.relu(x)
    x = @conv2.call(x)
    x = Torch::NN::F.max_pool2d(x, 2)
    x = @dropout1.call(x)
    x = Torch.flatten(x, start_dim: 1)
    x = @fc1.call(x)
    x = Torch::NN::F.relu(x)
    x = @dropout2.call(x)
    x = @fc2.call(x)
    output = Torch::NN::F.log_softmax(x)
    output
  end
end

def train(model, device, train_loader, optimizer, epoch)
  model.train
  train_loader.each_with_index do |(data, target), batch_idx|
    data, target = data.to(device), target.to(device)
    optimizer.zero_grad
    output = model.call(data)
    loss = Torch::NN::F.nll_loss(output, target)
    loss.backward
    optimizer.step
    if batch_idx % 2 == 0
      puts "Train Epoch: %d [%5d/%d (%.0f%%)] Loss: %.6f" % [
        epoch, batch_idx * data.size(0), train_loader.dataset.size,
        100.0 * batch_idx / train_loader.size, loss.item
      ]
    end
  end
end

def test(model, device, test_loader)
  model.eval
  test_loss = 0
  correct = 0
  Torch.no_grad do
    test_loader.each do |data, target|
      data, target = data.to(device), target.to(device)
      output = model.call(data)
      test_loss += Torch::NN::F.nll_loss(output, target, reduction: "sum").item
      pred = output.argmax(1, keepdim: true)
      correct += pred.eq(target.view_as(pred)).sum.item
    end
  end

  test_loss /= test_loader.dataset.size

  puts "Test set: Average loss: %.4f, Accuracy: %d/%d (%.0f%%)\n\n" % [
    test_loss, correct, test_loader.dataset.size,
    100.0 * correct / test_loader.dataset.size
  ]
end

epochs = 14
lr = 1.0
gamma = 0.7
batch_size = 64
seed = 1

Torch.manual_seed(seed)

use_cuda = Torch::CUDA.available?
device = Torch.device(use_cuda ? "cuda" : "cpu")

def normalize(tensor, mean, std)
  tensor.sub(mean).div(std)
end

data = Npy.load_npz("mnist.npz")
datasets = [data["x_train"], data["y_train"], data["x_test"], data["y_test"]]
x_train, y_train, x_valid, y_valid = datasets.map { |ds| Torch.from_numo(ds) }
x_train = normalize(x_train.float.reshape([60000, 1, 28, 28]) / 255, 0.1307, 0.3081)
x_valid = normalize(x_valid.float.reshape([10000, 1, 28, 28]) / 255, 0.1307, 0.3081)

train_dataset = Torch::Utils::Data::TensorDataset.new(x_train, y_train.long)
test_dataset = Torch::Utils::Data::TensorDataset.new(x_valid, y_valid.long)

train_loader = Torch::Utils::Data::DataLoader.new(train_dataset, batch_size: batch_size)
test_loader = Torch::Utils::Data::DataLoader.new(test_dataset, batch_size: batch_size)

model = Net.new.to(device)
optimizer = Torch::Optim::Adadelta.new(model.parameters, lr: lr)

scheduler = Torch::Optim::LRScheduler::StepLR.new(optimizer, step_size: 1, gamma: gamma)
1.upto(epochs) do |epoch|
  train(model, device, train_loader, optimizer, epoch)
  test(model, device, test_loader)
  scheduler.step
end
