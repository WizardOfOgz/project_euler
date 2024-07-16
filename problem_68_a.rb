# Magic 5-gon ring
# https://projecteuler.net/problem=68

s = (1..10).to_a

# In order to find a 16-digit string, 10 must be an outer node.
inner_ring_node_candidates = s - [10]

inner_ring_candidates = inner_ring_node_candidates.permutation(5).lazy
  .map { |inner_ring_candidate|
    outer_ring_values = s - inner_ring_candidate
    outer_ring_sum = outer_ring_values.sum

    # Find the value which each line should sum to.
    line_sum = (2 * inner_ring_candidate.sum + outer_ring_sum) / 5

    inner_pairs = [*inner_ring_candidate, inner_ring_candidate.first].each_cons(2)

    [inner_ring_candidate, outer_ring_values, line_sum, inner_pairs]
  }
  .select do |inner_ring_candidate, outer_ring_values, line_sum, inner_pairs|
    # outer_ring_values = s - inner_ring_candidate
    # outer_ring_sum = outer_ring_values.sum

    # # Find the value which each line should sum to.
    # line_sum = (2 * inner_ring_candidate.sum + outer_ring_sum) / 5

    inner_sums = inner_pairs.map(&:sum)

    min_inner_sum = line_sum - outer_ring_values.max
    max_inner_sum = line_sum - outer_ring_values.min

    # pp ">>>", min_inner_sum, max_inner_sum, inner_sums

    # Valid inner ring candidates have the following properties:
    # * The sum of each pair of connected nodes should be unique amongst all other pairs.
    # * Each pair of connected nodes should sum with at least one of the outer ring values to meet the target line sum.
    inner_sums.uniq.length == 5 && inner_sums.all? { |d| min_inner_sum <= d && d <= max_inner_sum }
  end

# pp inner_ring_candidates
pp inner_ring_candidates.count

pp inner_ring_candidates.first

ts = inner_ring_candidates.map do |inner, outer, line_sum, inner_pairs|
  triples = inner_pairs.map { |a, b|
    outer_value = outer.find { |x| x == line_sum - a - b }
    outer_value && [outer_value, a, b]
  }
  if triples.none?(&:nil?)
    triples.sort do |(a1, a2, a3), (b1, b2, b3)|
      if a1 != b1
        a1 <=> b1
      elsif a2 != b2
        a2 <=> b2
      else
        a3 <=> b3
      end
    end
  end
end.compact

pp ts.map {|t| Integer(t.flatten.join, 10)}.min



exit 0






pp (1..10).to_a
  .combination(5)
  .map {|c|
    c.permutation(5)
      .map {|l| [*l, l.first] }
      .select {|l| l.each_cons(2).reduce(&:+).map(&:abs).uniq.length == 5}
  }
exit

pp (1..6).to_a
  .combination(3) # Get all possible combination of inner numbers, e.g. [1,2,3], [2,3,4], ...
  .map { |l|
    [l, ((1..6).to_a) - l] # Use set difference to get outer numbers e.g. [[1,3,5], [2,4,6]], [[1,2,3], [4,5,6]]
  }
  .select { |l|
    l.map { |m|
      m.combination(2)
        .map { |n|
          n.reduce(&:-).abs
        }
        .sum
      }.uniq.length == 1
  }
  .select {|l| l.all? { |m| m.sum % 3 === 0 }}
exit

pp (1..10).to_a
  .combination(5) # Get all possible combination of inner numbers, e.g. [1,2,3,4,5], [3,4,5,6,7], ...
  .map { |l|
    [l, ((1..10).to_a) - l] # Use set difference to get outer numbers e.g. [[1,3,5,7,9], [2,4,6,8,10]], [[1,2,3,4,5], [6,7,8,9,10]]
  }
  .select { |l|
    l.map { |m|
      m.combination(2)
        .map { |n|
          n.reduce(&:-).abs
        }
        .sum
      }.uniq.length == 1
  }
  # .each_cons(2)
  # .select {|l| l.map { |a,b| a + b }.uniq.length == 1 }
