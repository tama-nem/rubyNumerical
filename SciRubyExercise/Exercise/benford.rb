# frozen_string_literal: true

require './SciRubyExercise/PlotTemplate/gnuplotModule'

def calcMean(lastInt)
  total = (0..9).map{0.0}
  (1..lastInt).each {|i| total[i.to_s[0].to_i] += 1.0}
  return total.map {|t| t/(lastInt.to_f)}
end

def getNewBIValue(benford_integral, meani, mean, firstTime)
  ans =
    if firstTime
      mean
    else
      mean + benford_integral[meani].last
    end
  return ans
end

# Main----------------------------------------------
first = 1
last = 3000
capital = (0..9).to_a

# Define and Initialize Arrays
# Probability that the letter exists at head of number.
benford = capital.map { Array.new(0.0) }
# Total of Mean Value from 'first' number
benford_integral = (0..9).map { Array.new(0.0) }
# Integrated Reglated Probability that the letter exists at head of number.
benford_integral_reg = capital.map { Array.new(0.0) }

# Main Calculation
(first..last).each do |i|
  integral_total_of_i = 0.0

  calcMean(i).each_with_index do |mean, meani|
    benford[meani] << mean

    newBIValue = getNewBIValue(benford_integral, meani, mean, i==first)
    integral_total_of_i += newBIValue
    benford_integral[meani] << newBIValue
  end

  (0..9).each do |integ_reg_i|
    benford_integral_reg[integ_reg_i] << \
     benford_integral[integ_reg_i].last / integral_total_of_i
  end
end

# Preparation to plot
xyArray = []
capital.each do |plti|
  xyArray << (first..last).to_a
  xyArray << benford_integral_reg[plti]
end

# Plot
GnuplotModule.plotxyMulti_2DimArray(xyArray, capital.map{
    |i| "Probability of #{i}"
})
