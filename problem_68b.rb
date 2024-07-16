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

NUM_WORKERS = 10

pipe = Ractor.new do
  loop do
    Ractor.yield Ractor.receive
  end
end

workers = NUM_WORKERS.times.map do
  Ractor.new(pipe) do |pipe|
    puts "-->"
    while nodes = pipe.take
      lines = nodes[0..4].zip([*nodes[-5..-1], nodes[-5]].each_cons(2).to_a)
        .map(&:flatten) # Ex. => [[1, 6, 7], [2, 7, 8], [3, 8, 9], [4, 9, 10], [5, 10, 6]]
      # puts lines.inspect
      if lines.map(&:sum).uniq.length == 1
        Ractor.yield lines.sort_by { |(a,_b,_c)| a }
      end
    end
  end
end

task_count = (1..10).to_a.permutation(10).each do |nodes|
  pipe << nodes
end.count

solutions = []


task_count.times do
  _ractor, nodes = Ractor.select(*workers)
  solutions << nodes if nodes
end

# Benchmark.ips do |x|
#   task_count.times do
#     _ractor, nodes = Ractor.select(*workers)
#     solutions << nodes if nodes
#   end
# end

pp task_count, solutions
