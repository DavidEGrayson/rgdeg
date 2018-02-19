require_relative 'spec_helper'
require 'rgdeg/breadth_first_search_dag'

describe :breadth_first_search_dag do
  specify 'works with a basic hash-array graph' do
    graph = { 1 => [2, 3, 4], 2 => [5, 6], 3 => [], 4 => [7, 8], 5 => [],
              6 => [], 7 => [], 8 => [], 9 => 10 }
    nodes = []
    result = breadth_first_search_dag(graph, 1) do |node|
      nodes << node
    end
    expect(result).to eq nil
    expect(nodes).to eq (1..8).to_a
  end
end
