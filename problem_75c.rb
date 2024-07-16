#  1810116=>1,
#  1809658=>1}
# Unique lengths: 193734

# real	3049m25.989s
# user	1740m44.921s
# sys	23m49.121s


# Singular integer right triangles
# https://projecteuler.net/problem=75

# It turns out that 12 cm is the smallest length of wire that can be bent to form an integer sided right angle triangle in exactly one way, but there are many more examples.

# 12 cm: (3,4,5)
# 24 cm: (6,8,10)
# 30 cm: (5,12,13)
# 36 cm: (9,12,15)
# 40 cm: (8,15,17)
# 48 cm: (12,16,20)

# In contrast, some lengths of wire, like 20 cm, cannot be bent to form an integer sided right angle triangle, and other lengths allow more than one solution to be found; for example, using 120 cm it is possible to form exactly three different integer sided right angle triangles.

# 120 cm: (30,40,50), (20,48,52), (24,45,51)

# Given that L is the length of the wire, for how many values of L ≤ 1,500,000 can exactly one integer sided right angle triangle be formed?

require 'set'

# A single side of the triangle must be < 1,500,000 / 2
# SQUARES = Set.new((1..750_000).map { |s| s ** 2 })
SQUARES = Set.new((1..100).map { |s| s ** 2 })

# combinations = []
length_counters = Hash.new { |h,k| h[k] = 0 }

SQUARES.lazy.each do |x|
  SQUARES.lazy.drop_while { |s| s < x }.each_cons(2).each do |prev_y, y|
    puts [x, y, length_counters.length].inspect if (x + y) % 10_000 == 0
    if SQUARES.include?(x + y)
      # combinations << [x, y, (x + y) * 2]
      length_counters[Integer.sqrt(x) + Integer.sqrt(y) + Integer.sqrt(x + y)] += 1
    end
  end
end

# puts "Combinations: \n#{combinations.inspect}"

pp length_counters

puts "=======================\nUnique counters:\n"

unique_lengths = length_counters.select { |k,v| v == 1 }
pp unique_lengths

puts "Unique lengths: #{unique_lengths.length}"
