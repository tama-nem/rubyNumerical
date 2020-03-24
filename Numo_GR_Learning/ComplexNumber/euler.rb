# frozen_string_literal: true

require './Numo_GR_Learning/ComplexNumber/plot_complex_plane'

x = (1..10).to_a
ei = x.map { |it| Math.exp(1)**(2 * Math::PI * 1i / it) }
puts ei

PlotComplexPlane.plot_complex(ei)
