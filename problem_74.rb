# Digit factorial chains
# https://projecteuler.net/problem=74

# The number 145 is well known for the property that the sum of the factorial of its digits is equal to 145:

# 1! + 4! + 5! = 1 + 24 + 120 = 145

# Perhaps less well known is 169, in that it produces the longest chain of numbers that link back to 169; it turns out that there are only three such loops that exist:

# 169 → 363601 → 1454 → 169
# 871 → 45361 → 871
# 872 → 45362 → 872

# It is not difficult to prove that EVERY starting number will eventually get stuck in a loop. For example,

# 69 → 363600 → 1454 → 169 → 363601 (→ 1454)
# 78 → 45360 → 871 → 45361 (→ 871)
# 540 → 145 (→ 145)

# Starting with 69 produces a chain of five non-repeating terms, but the longest non-repeating chain with a starting number below one million is sixty terms.

# How many chains, with a starting number below one million, contain exactly sixty non-repeating terms?

require 'set'
load 'utils/fac.rb' # Integer#fac

digit_fac = Hash[(0..9).zip((0..9).map(&:fac))].freeze

# permutations of the same digits will produce the same chain, so only unique combinations of digits need to be checked

graph = {}

(1...1_000_000).each do |x|
  # print "\r           \r#{x}" if x & 0b1111111 == 0
  n = x
  path = Set.new
  while !graph.include?(n)
    path << n
    m = n.digits.map {|k| digit_fac[k]}.sum
    graph[n] = { m: }
    n = m
  end

  if path.include?(n)
    # new loop formed - set the length of each member to the loop length
    loop_path = path.drop_while { |j| j != n }
    loop_path.each do |j|
      graph[j][:length] = loop_path.length
    end
  end

  # Set the length of all non-repeating path elements
  path.take_while { |j| !graph[j][:length] }.reverse.each do |j|
    g = graph[j]
    r = g[:length] = graph[g[:m]][:length] + 1
  end
end

puts graph.select { |x, g| g[:length] == 60 }.count
