# frozen_string_literal: true

require 'numo/gnuplot'

Numo.gnuplot do
  set title: 'TITLE'
  plot 'sin(x)', { w: :lines },
       'cos(x)', { w: :lines },
       'x/10',   { w: :lines }
  sleep 3
end
