require 'daru'
require './SciRubyExercise/daruShortcut'

# Reference: "The basic of AI Programming with Python" Section 2.3
module Preprocessing

  module_function

  def binarize(sourceArray, threshold)
    if sourceArray[0].is_a?(Array)
      sourceArray.map{ |i| binarize(i, threshold) }
    else
      sourceArray.map{ |i| i>threshold ? 1 : 0}
    end
  end

  def scaling(dataFrame)
    stdev=dataFrame.std
    mean=dataFrame.mean

    return convertDataFrame(dataFrame) {|col, _lin, value|
      (value-mean[col])/stdev[col] }
  end

  # Ref: https://helve-python.hatenablog.jp/entry/scikitlearn-scale-conversion#%E6%AD%A3%E8%A6%8F%E5%8C%96%E6%9C%80%E5%A4%A71-%E6%9C%80%E5%B0%8F0%E3%81%99%E3%82%8B
  def minmaxScaling(dataFrame)
    min=dataFrame.min
    max=dataFrame.max

    return convertDataFrame(dataFrame) {|col, _lin, value|
      (value-min[col]) / (max[col]-min[col]) }
  end

  def convertDataFrame(dataFrame)
    ans=dataFrame
    linsize, colsize = dataFrame.shape

    (0...colsize).each do |col|
      (0...linsize).each do |lin|
        value = dataFrame[col][lin]
        ans[col][lin] = yield(col, lin, value)
      end
    end

    ans
  end
end

# Main Program------------------

test = [[5.1, -2.9, 3.3],
        [-1.2, 7.8, -6.1],
        [3.9, 0.4, 2.1],
        [7.3, -9.9, -4.5]]
p Preprocessing.binarize(test, 2.1)

df = DaruShortcut.getDefaultDFWithLines(test)
scaled = Preprocessing.scaling(df)
p scaled
p scaled.mean
p scaled.std

# I Think scaled.mean[0] !=~ 0 is because of Bug of Daru. (_ _;)
# Conformation:
m = scaled[0].inject { _1 + _2 }
p m / scaled.shape[1]
# Exactly It's answer is almost 0.

p Preprocessing.minmaxScaling(df)
