require 'set'

module Rgdeg
  # Computes the transitive reduction of a directed acyclic graph (DAG).  The
  # transitive reduction is a new graph which has the same transitive closure,
  # as the original while having a minimum number of edges.
  #
  # This algorithm only works with DAGs.  It will detect cycles and raise an
  # exception.
  def transitive_reduction(graph)
    tr = {}
    graph.each do |start_node, nodes|
      nodes_with_max_distance_1 = Set.new(nodes)
      distance = 1
      until nodes.empty?
        nodes = Set.new nodes.flat_map &graph.method(:fetch)
        distance += 1
        nodes_with_max_distance_1 -= nodes
        if distance > graph.size
          raise "Cycle detected: this algorithm only works with DAGs."
        end
      end
      tr[start_node] = nodes_with_max_distance_1.to_a
    end
    tr
  end
end
