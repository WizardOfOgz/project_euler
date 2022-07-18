require 'prime'
require 'set'

results = Enumerator.new do |yielder|
  prime_generator = Prime.each

  cliques = []
  node_index = Hash.new { |h, k| h[k] = Set.new }

  loop do
    x = prime_generator.next

    s = x.to_s

    (1...s.length).each do |i|
      next if %w[2 4 6 8 0].include?(s[i-1]) || (s.length > 1 && s[i - 1] == "5") || (i == s.length - 1 && s[i] == "5") || (s[i] == "0")
      s1 = s[0...i]
      next unless s1.to_i.prime?
      s2 = s[i..-1]
      next unless s2.to_i.prime?
      r = s2 + s1
      next unless r.to_i.prime?

      # add to cliques
      [s1, s2].each do |node|
        cliques.each do |clique|
          if clique.all? { |clique_node| (node + clique_node).to_i.prime? && (clique_node + node).to_i.prime? }
            clique << node
            node_index[node] << clique
          end
        end
      end

      # create new clique if both numbers are not in the same clique
      if (node_index[s1] & node_index[s2]).empty?
        cliques << Set.new.tap { |clique|
          clique << s1
          clique << s2
        }
      end
    end

# puts cliques.inspect
# biggest = cliques.max { |c1, c2| c1.length <=> c2.length }
# puts "#{ x }: #{ biggest.inspect if biggest }"

    if winner = cliques.detect { |clique| clique.length >= 5 }
      yielder << winner
    end
  end
end


puts results.next.inspect
