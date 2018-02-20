require_relative 'spec_helper'
require 'rgdeg/depth_first_search'

describe :depth_first_search do
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => 10 }
    nodes = enum_for(:depth_first_search, graph, 1).to_a
    expect(nodes).to eq [1, 2, 5, 6, 3, 4, 7, 8]
  end

  it 'does not search the same node twice' do
    graph = { 1 => [2, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    nodes = enum_for(:depth_first_search, graph, 1).to_a
    expect(nodes).to eq [1, 2, 4, 5, 3]
  end

  it 'returns nil' do
    graph = { 1 => [1] }
    expect(depth_first_search(graph, 1) { }).to eq nil
  end
end
