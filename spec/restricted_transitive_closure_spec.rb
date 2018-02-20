require_relative 'spec_helper'
require 'rgdeg/restricted_transitive_closure'

describe :restricted_transitive_closure do
  it 'works one a simple hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => [10], 10 => [], 11 => [] }
    allowed = Set.new([1, 5, 6, 4, 8, 9])
    expect(restricted_transitive_closure(graph, allowed)).to eq({
      1 => [5, 6, 4, 8], 5 => [], 6 => [], 4 => [8], 8 => [], 9 => []
    })
  end

  it 'works on graphs with cycles' do
    graph = { 1 => [2], 2 => [3], 3 => [1] }
    allowed = [1, 2, 44]
    expect(restricted_transitive_closure(graph, allowed)).to eq({
      1 => [2, 1], 2 => [1, 2],
    })
  end
end
