# frozen_string_literal: true

require 'daru'
require './SciRubyExercise/daruShortcut'
require './SciRubyExercise/PlotTemplate/gnuplotModule'

array_example = [[1,2,3,4,5], [2,3,4,5,6],[-5,6,0,2,4]]
puts ''

df = DaruShortcut.getDefaultDF(array_example)
p df
puts ''

puts 'Example of Getting a Column'
p df['col0']
puts ''

puts "Example of Method 'describe'"
p df.describe
puts ''

puts 'Example of Converting a Column to Array'
puts "Please refer the above method 'convertArray'"
array_col = (0..2).map { DaruShortcut.convertArray(df, _1) }

GnuplotModule.plotxyMulti(array_col[0], array_col[1], \
                          array_col[0], array_col[2])
