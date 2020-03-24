require 'daru'

# Data Preporecessing Exercise ... It doesn't work as expected..
module Preprocessing
  module_function

  def getDF(square_array)
    tr = square_array.transpose
    hash_source = {}

    tr.each_with_index do |child_array, i|
      hash_source["col#{i}"] = child_array
    end
    Daru::DataFrame.new(hash_source)
  end

  def scaling(dataframe)
    stdev = dataframe.std
    mean = dataframe.mean

    convertDataFrame(dataframe) do |col, _, value|
      (value - mean[col]) / stdev[col]
    end
  end

  def convertDataFrame(dataframe)
    ans = dataframe
    linsize, colsize = dataframe.shape

    (0...colsize).each do |col|
      (0...linsize).each do |lin|
        value = dataframe[col][lin]
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

df = Preprocessing.getDF(test)
puts 'Source Data is:'
p df

puts 'Scaled Data is:'
scaled = Preprocessing.scaling(df)
p scaled
p scaled.mean
p scaled.std

# The mean of column.0 is not 0?
# Conformation:
cal_mean = scaled[0].inject { _1 + _2 }
puts 'Calculated mean of col[0] is:'
puts cal_mean / scaled.shape[1]
# Exactly it's answer is almost 0.
