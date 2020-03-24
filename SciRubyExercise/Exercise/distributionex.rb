# frozen_string_literal: true

require 'distribution'
require './SciRubyExercise/PlotTemplate/gnuplotModule'

DN = Distribution::Normal

x = (-300..300).map { _1.to_f * 0.01 }
y = x.map { DN.pdf(_1) }
# BTW: pdf is abb. of (normal) probability density function.

puts "y.class = #{y.class}"
GnuplotModule.plotxyMulti(x, y)
