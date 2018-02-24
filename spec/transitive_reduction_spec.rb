require_relative 'spec_helper'
require 'rgdeg/transitive_reduction'

describe :transitive_reduction do
  it 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4, 5], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    tr = transitive_reduction(graph)
    expected_tr = { 1 => [2, 3], 2 => [4], 3 => [4], 4 => [5], 5 => [] }
    expect(tr).to eq expected_tr
  end
end
