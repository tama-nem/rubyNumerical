# frozen_string_literal: true

require './Numo_GR_Learning/ComplexNumber/plot_complex_plane'

def solve1(a, b, c)
  (c - b) / a
end

imaginary_array = []
imaginary_array[0] = [10 + 5i, 20 + 2i, 12 - 4i]
(1..15).each do |i|
  imaginary_array[i] = imaginary_array[i - 1].map do
    _1 * Complex.polar(1.2, Math::PI / 4.0)
  end
end

# e.g. of Multipe Plotting---
# x = DFloat.linspace(0, 10, 1001)
# y1 = NMath.sin(x)
# y2 = NMath.cos(x)
# GR.plot([x, y1], [x, y2], labels: ["y = sin(x)", "y = cos(x)"])
# ---------------------------
# Referencing above,
# Let us try plotting imaginary number arrays to complex plane
PlotComplexPlane.plot_complex_line(*imaginary_array)

puts solve1(10, 5, 30)
puts solve1(10 + 5i, 5, 20)
puts solve1(10.0 + 5.0i, 5.0, 20.0)

im_eg = 2 + 3i
puts(im_eg.abs)
puts(im_eg.conjugate)
