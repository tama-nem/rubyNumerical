# frozen_string_literal: true

require 'numo/narray'
require 'numo/gnuplot'
require 'rumale'
require './ML/narray_wrapper'

include Numo

RP = Rumale::Preprocessing
NAW = NArrayWrapper

input_data = NArray[[5.1, -2.9, 3.3],
                    [-1.2, 7.8, -6.1],
                    [3.9, 0.4, 2.1],
                    [7.3, -9.9, -4.5]]

# 2.3.1 Binalize
puts "Binalize Test----------"
bin_data = NAW.binalize!(input_data, 2.1)
p bin_data

# 破壊的メソッドで変更されてしまうので、定義し直し
input_data = NArray[[5.1, -2.9, 3.3],
                    [-1.2, 7.8, -6.1],
                    [3.9, 0.4, 2.1],
                    [7.3, -9.9, -4.5]]

# 2.3.2 平均値を引いて scaling
puts "Average Deducted Scaling Test----------"
nmlzed = RP::StandardScaler.new.fit_transform(input_data)
puts "Normalized:"
p nmlzed
# axis:0は「各列について表示せよ」 1だと「各行について」numpyと同じ
puts "Its Mean:"
p nmlzed.mean(axis:0)
puts "Its STDDEV:"
p nmlzed.stddev(axis:0)

# 2.3.3 スケーリング (minmax)
puts "Min-Max Scaling Test----------"
p RP::MinMaxScaler.new(feature_range:[0.0,1.0]).fit_transform(input_data)

# 2.3.4 L1,L2正規化(正則化)
puts "L1 Normalization Test----------"
p NAW.normalize_L1(input_data)
puts "L2 Normalization Test----------"
p RP::L2Normalizer.new.fit_transform(input_data)
