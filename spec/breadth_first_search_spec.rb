require_relative 'spec_helper'
require 'rgdeg/breadth_first_search'

describe :breadth_first_search do
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => [10], 10 => [] }
    nodes = enum_for(:breadth_first_search, graph, 1).to_a
    expect(nodes).to eq (1..8).to_a
  end

  it 'does not search the same node twice' do
    graph = { 1 => [2, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    nodes = enum_for(:breadth_first_search, graph, 1).to_a
    expect(nodes).to eq (1..5).to_a
  end

  it 'works on a graph with cycles' do
    graph = { 1 => [2], 2 => [1] }
    nodes = enum_for(:breadth_first_search, graph, 1).to_a
    expect(nodes).to eq [1, 2]
  end

  it 'returns nil' do
    graph = { 1 => [1] }
    expect(breadth_first_search(graph, 1) { }).to eq nil
  end
end
