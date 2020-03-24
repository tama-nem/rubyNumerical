require 'daru'
require './SciRubyExercise/daruShortcut'

D=Daru
DS=DaruShortcut

df = D::DataFrame.new([[1,2],[3,4]])
# df is :
#   0  1
# 0 1  3
# 1 2  4

# You can designate column names like this:
df_column_named = D::DataFrame.new(a:[1,2,3],b:[2,3,4])
# This is :
#   :a  :b
# 0  1   2
# 1  2   3
# 2  3   4

# And you even can designate row names.
df_colrow_named = Daru::DataFrame.new({a:[1,2,3], b:[4,5,6]}, index: [:a,:b,:c])
# This is :
#    :a  :b
# :a  1   4
# :b  2   5
# :c  3   6

# Merely [1] means column 1 (2nd column) Vector.
puts df[1].mean
# But, hen you define column name,
# you can designate column with it.
puts df_column_named[:a].mean

# How about rows designation?
puts df.row[1].mean
puts df_colrow_named.row[:a].mean
# OK, that's right.
# By the way, the below code causes error.
#  puts df.column[1].mean

# How about Getting One Item?
puts df[1][1]
# => 4 OK.

# How can we get each items?
puts 'Test of each(Column Prior)'
df.each { |col| col.each { puts " #{_1}" } }
puts 'End Test of Each'

puts 'Test of each(Row Prior)'
puts "But it's not smart(..;)"
puts 'Anyway, I write it in daruShorcut.rb'
(0..(df[1] - 1)).each do
  df.row[i].each { puts " #{_1}" }
end
puts 'End Test of Each'

# filtering
df2 = D::DataFrame.new([[5,6,7], [8,9,10]])
# df2 is :
#   0   1
# 0 5   8
# 1 6   9
# 2 7  10
df3 = df2.filter(:row) { |row| row[1] > 8 }
# df3 is :
#   0   1
# 0 6   9
# 2 7  10

# conformation
puts 'Filter Conformation'
DS.each_with_column(df3) { puts " #{_1}" }

# How can we join two data frames?
df4 = df2.concat(df3)
# df4 is :
#   0   1
# 0 5   8
# 1 6   9
# 2 7  10
# 3 6   9
# 4 7  10

# conformation
puts 'Concat Conformation'
DS.each_with_column(df4) { puts " #{_1}" }
