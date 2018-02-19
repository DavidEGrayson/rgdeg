module Rgdeg
  # Easy modifications:
  #
  # Multiple starting points: If you want this function to either accept a
  # single node as its starting point or accept an array of nodes as a starting
  # point, change the first line to:
  #
  #   queue = Array(start)
  #
  # We can't do that in the main version because it breaks applications that
  # using nodes that are arrays.
  #
  # Avoid passing a block: If you want the results of the search to be returned
  # as an enumerator, use Ruby's enum_for method.  You can then then just use
  # that enumerator, or call Ruby's to_a method to convert it to an array:
  #
  #   enum_for(:breadth_first_search_dag, graph, start).to_a
  #
  def breadth_first_search_dag(graph, start)
    queue = [start]
    until queue.empty?
      node = queue.shift
      queue.concat(graph.fetch(node))
      yield node
    end
  end
end
