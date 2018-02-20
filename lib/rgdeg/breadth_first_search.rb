require 'set'

module Rgdeg
  # Given a graph, a starting node, and a Ruby block, this routine does a
  # breadth-first search, yielding the starting node and all the nodes reachable
  # from it.
  #
  # This routine keeps track of which nodes it has yielded and never yields the
  # same node twice.  If your graph has cycles, this prevents infinite loops.
  # If your graph doesn't have cycles (DAG), this is probably still a good idea
  # because it could save time.
  #
  # The graph should be a hash whose keys are nodes and whose values are arrays
  # of directly reachable nodes.  There should be a key in the hash for every
  # node.
  #
  # Easy modifications
  # ====
  #
  # Multiple starting points: If you want this routine to either accept a single
  # node as its starting point or accept an array of nodes as a starting point,
  # change "start" to "Array(start)" in the the first line.  We can't do that in
  # the main version because it breaks applications that use arrays as nodes.
  #
  # Multiple visits: If you don't care about the same node being searched
  # multiple times, just remove the three lines of code that refer to 'visited'.
  #
  # Avoid passing a block: If you want the results of the search to be returned
  # as an enumerator, use Ruby's enum_for method.  You can then then just use
  # that enumerator, or call Ruby's to_a method to convert it to an array:
  #
  #   enum_for(:breadth_first_search_dag, graph, start).to_a
  #
  def breadth_first_search(graph, start)
    queue = [start]
    visited = Set.new
    until queue.empty?
      node = queue.shift
      next if visited.include?(node)
      visited << node
      queue.concat(graph.fetch(node))
      yield node
    end
  end
end
