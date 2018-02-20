require_relative 'spec_helper'
require 'rgdeg/depth_first_search'

shared_examples_for 'depth first search routines' do |routine|
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => [10], 10 => [] }
    nodes = enum_for(routine, graph, 1).to_a
    expect(nodes).to eq [1, 2, 5, 6, 3, 4, 7, 8]
  end

  it 'does not search the same node twice' do
    graph = { 1 => [2, 4, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    nodes = enum_for(routine, graph, 1).to_a
    expect(nodes).to eq [1, 2, 4, 5, 3]
  end

  it 'works on a graph with cycles' do
    graph = { 1 => [2], 2 => [1] }
    nodes = enum_for(routine, graph, 1).to_a
    expect(nodes).to eq [1, 2]
  end

  it 'returns nil' do
    graph = { 1 => [1] }
    expect(send(routine, graph, 1) { }).to eq nil
  end
end

describe :depth_first_search do
  it_behaves_like 'depth first search routines', :depth_first_search
end

describe :depth_first_search_rec do
  it_behaves_like 'depth first search routines', :depth_first_search_rec
end
