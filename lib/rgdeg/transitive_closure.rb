require_relative 'depth_first_search'

module Rgdeg
  # Returns the transitive closure of the graph.  The transitive closure is a
  # new graph that has an edge from node X to node Y if and only if Y was
  # reachable from X in the old graph.
  def transitive_closure(graph)
    tc = {}
    graph.each_key do |node|
      tc[node] = enum_for(:depth_first_search_exclude_start, graph, node).to_a
    end
    tc
  end
end
