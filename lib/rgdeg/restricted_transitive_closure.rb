require_relative 'depth_first_search'

module Rgdeg
  # Given a graph and an array or set of allowed nodes, returns the restricted
  # transitive closure (a term I made up).  The restricted transitive closure is
  # a new graph that only contains nodes that were in the original graph and in
  # the set of allowed nodes, and that has an edge from node X to node Y if and
  # only if Y was reachable from X in the old graph.
  def restricted_transitive_closure(graph, allowed)
    rtc = {}
    graph.each_key do |node|
      next if !allowed.include?(node)
      reached_nodes = []
      depth_first_search_exclude_start(graph, node) do |reached_node|
        next if !allowed.include?(reached_node)
        reached_nodes << reached_node
      end
      rtc[node] = reached_nodes
    end
    rtc
  end
end
