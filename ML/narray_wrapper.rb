# frozen_string_literal: true

require 'numo/narray'

# Make Syntax Suger
module NArrayWrapper
  module_function

  def binalize!(narray, threshold)
    if threshold > 1
      narray[narray < threshold] = 0
      narray[narray >= threshold] = 1
    elsif threshold > 0
      narray[narray < threshold] = 0
      narray[narray >= threshold] = 1
    else
      narray[narray >= threshold] = 1
      narray[narray < threshold] = 0
    end
    narray
  end

  def get_each_row(narray)
    narray.to_a.each { yield _1 }
  end

  def narray_from_2Darray(twodarray)
    Numo::NArray[*twodarray]
  end

  def normalize_L1(narray)
    ans=[]
    get_each_row(narray) do |row|

      ## This commented out method failed(wrong number).
      #abssum_of_row = row.inject { _1 + _2.abs }
      ## You have to write .abs also after _1
      ## Because first injected item would not be converted with .abs
      ## when you miss it.
      abssum_of_row = row.inject { _1.abs + _2.abs }
      ans.push row.map { _1 / abssum_of_row }
    end
    return narray_from_2Darray(ans)
  end
end

## example
# na = Numo::NArray[[1.0,2.0,3.0],[5.2,6.0,-2.0]]
# p NArrayWrapper.normalize_L1(na)
