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
    graph.each_key do |start_node|
      distance = 0
      nodes = Set.new([start_node])
      nodes_with_max_distance_1 = nil
      while nodes.size > 0
        new_nodes = Set.new
        nodes.each do |node|
          graph.fetch(node).each do |child|
            new_nodes << child
          end
        end
        nodes = new_nodes
        distance += 1

        if distance == 1
          nodes_with_max_distance_1 = nodes
        else
          nodes_with_max_distance_1 -= nodes
        end

        if distance >= graph.size
          raise "Cycle detected: this algorithm only works with DAGs."
        end
      end
      tr[start_node] = nodes_with_max_distance_1.to_a
    end
    tr
  end
end
