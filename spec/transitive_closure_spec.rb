require_relative 'spec_helper'
require 'rgdeg/transitive_closure'

describe :transitive_closure do
  it 'works one a simple hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => [10], 10 => [], 11 => [] }
    expect(transitive_closure(graph)).to eq({
      1 => [2, 5, 6, 3, 4, 7, 8], 2 => [5, 6], 3 => [],
      4 => [7, 8], 5 => [], 6 => [], 7 => [], 8 => [], 9 => [10],
      10 => [], 11 => []
    })
  end

  it 'works on graphs with cycles' do
    graph = { 1 => [2], 2 => [1] }
    expect(transitive_closure(graph)).to eq({
      1 => [2, 1], 2 => [1, 2],
    })
  end
end
