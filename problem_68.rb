# Magic 5-gon ring
# https://projecteuler.net/problem=68

# Special Pythagorean triplet
# https://projecteuler.net/problem=9


# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
# a2 + b2 = c2

# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

require 'benchmark/ips'

OUTER = (0..10).to_a.freeze
INNER = (0..9).to_a.freeze

def gen(outers = OUTER, inners = INNER, middle = nil, target_sum = nil)
  # pp "gen #{ outers }, #{ inners }"
  Enumerator.new do |yielder|
    outers.each do |outer|
      # pp "outer loop #{outer}"
      (inners - [outer]).each do |inner|
        # pp "inner loop #{inner}"
        new_line = [outer, inner]
        remaining_inners = inners - new_line
        remaining_outers = outers - new_line

        # continue to the next option if the current values would result in an
        # invalid graph.
        line_sum = middle && (outer + inner + middle)
        if target_sum && line_sum != target_sum
          # puts <<~EOM
          #   rejecting
          #     outer: #{outer}
          #     inner: #{inner}
          #     middle: #{middle}
          #     target_sum: #{target_sum}
          #     line_sum: #{line_sum}
          # EOM
          next
        end

        # pp "<-> #{new_line} #{outers} #{inners} -> #{ remaining_outers } #{ remaining_inners }"

        if remaining_inners.empty? || remaining_outers.empty?
          # pp '->'
          yielder << [new_line]
        else
          # pp '--'
          gen(remaining_outers, remaining_inners, new_line.last, line_sum).each do |result|
            # pp '<-'
            yielder << [new_line, *result]
          end
        end
      end
    end
  end
end

pp (gen((1..10).to_a, (1..9).to_a).reject do |r|
# pp (gen((1..6).to_a, (1..6).to_a).reject do |r|
  target_sum = r.first.last + r[1].sum
  line_sum = r.last.last + r.first.sum

  # puts ":: #{ target_sum } #{ target_sum }"
  line_sum != target_sum
end.to_a)
.map{ |l|

  min_first_value = l.map(&:first).min
  idx = l.index  { |(a,*)| a == min_first_value }

  l.rotate!(idx)

  l.each_with_index.map {|(a,b), i|
    [a, l[i - 1].last, b]
  }
  }
  .uniq
  .map(&:flatten).map(&:join).map(&:to_i).max
# pp gen((1..4).to_a, (1..4).to_a).to_a

exit 0



def valid_lines?(lines)
  complete_lines = lines.select {|l| l.length == 3}
  complete_lines.empty? || complete_lines.map(&:sum).uniq.count == 1
end

def gen(outers = OUTER, inners = INNER, middle = nil, target_sum = nil)
  pp "--> #{outers}, #{ inners } - #{middle} - #{ target_sum }"
  return [[]].to_enum if outers.empty? || inners.empty?
  #   first_line = [*lines.first, lines.last[1]]
  #   puts "==> #{ lines }"
  #   return [first_line, *lines[1..-1]]
  # end

  # pp "lines: #{lines}"
  Enumerator.new do |yielder|
    outers.each do |outer|
      (inners - [outer]).each do |inner|
        # last_line = lines[-1]
        new_line = [outer, middle, inner]
        # if last_line
        #   last_line = [*last_line, inner]
        #   new_lines = [*lines[0..-2], last_line, new_line]
        # else
        #   new_lines = [new_line]
        # end

        # pp "~~> #{ new_lines }"
        # new_lines = [*lines[0..-1], Array[*last_line], [outer, inner]]
        # pp "#{outer} #{inner}, #{ target_sum } ? #{ new_lines }"
        # if valid_lines?(new_lines)
        target_sum ||= middle.nil? ? nil : new_line.sum
        pp ">>> #{new_line} -> #{ target_sum }"
        if target_sum.nil? || new_line.sum == target_sum
          remaining_inners = inners - [inner, outer]
          remaining_outers = outers - [outer, inner]
          pp "<-> #{ remaining_outers }"
          pp ">-< #{ remaining_inners }"

          if remaining_inners.any? && remaining_outers.any?
            gen(remaining_outers, remaining_inners, inner, target_sum).each do |result|
              pp "yield #{[new_line, *result]}"
              yielder << [new_line, *result]
            end
          else
            yielder << [new_line]
          end
        end
      end
    end
  end
end

pp gen((1..10).to_a, (1..10).to_a).to_a

exit 0











def gen(outers = OUTER, inners = INNER)
  Enumerator.new do |yielder|
    outers.each do |outer|
      (inners - [outer]).each do |inner|
        yielder << [outer, inner]
      end
    end
  end
end

def g(outers = OUTER, inners = INNER, lines = [])
  gen(outers, inners).each do |(outer, inner)|
    target_sum = lines.count > 1 ? lines.first.sum : nil
    last_line = lines[-1]
    last_line = [*last_line, inner] if last_line
    new_lines = [*lines, *last_line, [outer, inner]]
    pp "#{outer} #{inner}, #{ target_sum } ? #{ valid_lines?(new_lines) }"
    if valid_lines?(new_lines)
      remaining_inners = inners - [inner, outer]
      remaining_outers = outers - [outer, inner]
      gen(remaining_outers, remaining_inners, new_lines)
    end
  end
end

exit 0
















lines = []
e = Enumerator.new do |yielder|
  OUTER.each do |outer|
    (INNER - [outer]).each do |inner|

    end
  end
end

pp e.take(20).to_a

exit 0






def valid_lines?(lines)
  complete_lines = lines.select {|l| l.length == 3}
  complete_lines.empty? || complete_lines.map(&:sum).uniq.count == 1
end

def gen(outers = OUTER, inners = INNER, lines = [])
  e = Enumerator.new do |yielder|
    # pp "gen #{outers} #{inners} #{lines}"
    outers.each do |outer|
      (inners - [outer]).each do |inner|
        yielder << [outer, inner]
  #       target_sum = lines.count > 1 ? lines.first.sum : 0
  #       # if lines.last
  #       #   lines.last << inner
  #       # end
  #       # pp "> #{outer},#{inner}:#{lines}::#{lines.select {|l| l.length == 3}.map(&:sum).uniq.count}"
  #       pp "> #{outer},#{inner}:#{lines}::#{lines.last}"
  #       # next if lines.count > 1 && (lines.last.sum + inner) != lines.first.sum # lines.select {|l| l.length == 3}.map(&:sum).uniq.count > 1
  #       new_line = [outer, inner]
  #       next if target_sum &&

  #       remaining_inners = inners - [inner, outer]
  #       remaining_outers = outers - [outer, inner]
  # # pp "<<<", inner, outer, lines, remaining_inners
  #       if remaining_inners.any?
  #         # lines << gen(remaining_outers, remaining_inners, lines)
  #         gen(remaining_outers, remaining_inners, [*inner_lines, new_line])
  #       else
  #         new_line << lines.first[1]
  #       end
      end
    end
    # lines
  end

  Enumerator.new do |yielder|
    e.each do |outer, inner|
      target_sum = lines.count > 1 ? lines.first.sum : nil
      last_line = lines[-1]
      last_line = [*last_line, inner] if last_line
      new_lines = [*lines, *last_line, [outer, inner]]
      pp "#{outer} #{inner}, #{ target_sum } ? #{ valid_lines?(new_lines) }"
      if valid_lines?(new_lines)
        remaining_inners = inners - [inner, outer]
        remaining_outers = outers - [outer, inner]
        gen(remaining_outers, remaining_inners, new_lines)
      end
    end
  end
end

pp "--> #{ gen((1..6).to_a, (1..6).to_a).to_a }"
exit(0)

e = Enumerator.new do |yielder|
  available_outer = []

  # 1. pick an outer from available
  # 2. pick a middle (inner) node from available
  # 3. if completed lines do not have the same sum, backtrack

  lines =  []

  OUTER.each do |outer|
    INNER.each do |inner|
      if lines.last
        lines.last << inner
      end
      next if lines.select {|l| l.length == 3}.map(&:sum).uniq.count != 1

      pp lines
  end


  (1..9).to_a.sample
    ((1..10).to_a - inner).permutation(5).each do |outer|
      nodes = outer.zip([*inner, inner.first].each_cons(2)).map(&:flatten)
      next unless nodes.map(&:sum).uniq.count == 1
      yielder << nodes
    end
  end
end

# e = Enumerator.new do |yielder|
#   (1..9).to_a.permutation(5).each do |inner|
#     ((1..10).to_a - inner).permutation(5).each do |outer|
#       nodes = outer.zip([*inner, inner.first].each_cons(2)).map(&:flatten)
#       next unless nodes.map(&:sum).uniq.count == 1
#       yielder << nodes
#     end
#   end
# end

# Benchmark.ips do |x|
#   task_count.times do
#     _ractor, nodes = Ractor.select(*workers)
#     solutions << nodes if nodes
#   end
# end

# pp e.take(5)
