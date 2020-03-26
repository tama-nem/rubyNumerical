# frozen_string_literal: true

require 'numo/gnuplot'

Numo.gnuplot do
  set title: 'TITLE'
  set terminal: 'png'
  set output: "'exercise.png'"
  plot 'sin(x)', { w: :lines },
       'cos(x)', { w: :lines },
       'tan(x)/10',   { w: :lines }
end
