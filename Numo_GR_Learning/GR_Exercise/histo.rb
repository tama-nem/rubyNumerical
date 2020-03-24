# frozen_string_literal: true

require 'numo/narray'
require 'gr/plot'

data = Numo::DFloat.new(10_000).rand_norm
GR.histogram(data)
sleep 10
