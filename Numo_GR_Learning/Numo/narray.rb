# frozen_string_literal: true

require 'numo/narray'

# To indicate include line, defined a module
module NumoExercise
  include Numo

  intarray1 = NArray[1, 2, 3]
  intarray2 = NArray[2, 5, 6]
  intarray3 = Int32[[5, 3], \
                    [4, 7], \
                    [10, 5]]
  puts intarray1.dot intarray2
  puts intarray1.dot intarray3
  dotvect = intarray1.dot(intarray3)
  dotvect.each { |it| puts it }
end

NumoExercise
