require_relative 'spec_helper'
require 'rgdeg/breadth_first_search'

describe :breadth_first_search do
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => 10 }
    nodes = []
    result = breadth_first_search(graph, 1) do |node|
      nodes << node
    end
    expect(result).to eq nil
    expect(nodes).to eq (1..8).to_a
  end

  it 'does not search the same node twice' do
    graph = { 1 => [2, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    nodes = enum_for(:breadth_first_search, graph, 1).to_a
    expect(nodes).to eq (1..5).to_a
  end
end
