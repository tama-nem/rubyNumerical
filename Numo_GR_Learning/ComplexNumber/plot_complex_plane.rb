# frozen_string_literal: true

require 'gr/plot'

# For Shortcut of Plotting Complex Plane
module PlotComplexPlane
  module_function

  def real_image(imaginary_array)
    t = imaginary_array.map { |im| [im.real, im.imaginary] }
    t.transpose
  end

  def plot_complex(*imaginary_array)
    # imaginary_array eg. [[3i, 2i], [4i, 1+2i]]
    real_image_3darray = imaginary_array.map { |it| real_image(it) }
    # real_image_3darray eg. [[[0, 0], [3, 2]], [[0, 1], [4, 2]]]
    labels = (1..real_image_3darray.length).to_a.map(&:to_s)
    # GR.plot can be called like below.
    #   GR.scatter([[1, 2], [3, 4]], [[0, 1], [2, 5]], labels: ["plot1", "plot2"])
    # And use Variable Expansion for real_image_3darray...
    GR.scatter(*real_image_3darray, labels: labels)
    sleep 10
  end

  def plot_complex_line(*imaginary_array)
    real_image_3darray = imaginary_array.map { |it| real_image(it) }
    labels = (1..real_image_3darray.length).to_a.map(&:to_s)
    GR.plot(*real_image_3darray, labels: labels)
    sleep 10
  end
end
