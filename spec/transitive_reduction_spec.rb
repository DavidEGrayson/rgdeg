require_relative 'spec_helper'
require 'rgdeg/transitive_reduction'

describe :transitive_reduction do
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4, 5], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    expected_tr = { 1 => [2, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    tr = transitive_reduction(graph)
    expect(tr).to eq expected_tr
  end

  it 'works with a graph that almost looks like it has a cycle' do
    graph = { 1 => [2], 2 => [3], 3 => [4], 4 => [] }
    tr = transitive_reduction(graph)
    expect(tr).to eq graph
  end

  it 'raises an exception if there is a cycle' do
    graph = { 1 => [2], 2 => [3], 3 => [4], 4 => [1] }
    expect { transitive_reduction(graph) }.to raise_error RuntimeError, \
      "Cycle detected: this algorithm only works with DAGs."
  end
end
