require 'set'

module Rgdeg
  # Given a graph, a starting node, and a Ruby block, this routine does a
  # depth-first search, yielding the starting node and all
  # the nodes reachable from it.
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
  # change "[start]" to "Array(start)".  We can't do that in the main version
  # because it breaks applications that use arrays as nodes.
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
  def depth_first_search(graph, start)
    stack = [[start]]
    visited = Set.new
    until stack.empty?
      node = stack.last.pop
      if node.nil?
        stack.pop
        next
      end
      next if visited.include?(node)
      visited << node
      stack << graph.fetch(node).to_a.reverse
      yield node
    end
  end

  # Some people like the recursive version better.
  def depth_first_search_rec(graph, start)
    visited = Set.new
    search = lambda do |nodes|
      nodes.each do |node|
        next if visited.include?(node)
        visited << node
        yield node
        search.call(graph.fetch(node))
      end
    end
    search.call([start])
    nil
  end

  # Just like depth_first_search but does not yield the starting elemenet
  # automatically; only yields it if there are edges (a cycle) in the graph
  # leading from the starting element to itself.
  #
  # Used in transitive_closure.
  def depth_first_search_exclude_start(graph, start)
    stack = [graph.fetch(start).to_a.reverse]
    visited = Set.new
    until stack.empty?
      node = stack.last.pop
      if node.nil?
        stack.pop
        next
      end
      next if visited.include?(node)
      visited << node
      stack << graph.fetch(node).to_a.reverse
      yield node
    end
  end
end
