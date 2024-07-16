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

# e = Enumerator.new do |yielder|
#   i = 1
#   loop do
#     yielder << i ** 2
#     i += 1
#   end
# end

SQUARES = Set.new((1..750_000).map { |s| s ** 2 })
# SQUARES = Set.new((1..500_000).map { |s| s ** 2 })
EVEN_SQUARES = Set.new(SQUARES.select(&:even?))

def square_addends(n)
  target = n / 2
  ##
  EVEN_SQUARES.take_while { |s| s <= target }.each do |x|
    a = n - x
    return [x, a] if SQUARES.include?(a)
  end
  nil
end

e = Enumerator.new do |yielder|
  i = 1
  SQUARES.each do |s|
    puts s if s % 1_000_000 == 0
    addend1, addend2 = square_addends(s)
    yielder << [addend1, addend2, s].map(&Integer.method(:sqrt)) if addend1
  end
end

puts '-----------------=------------------'
# # pp e.take_while { |triple| triple.sum < 10_000 }.count
# result = e.group_by { |triple| triple.sum }
# pp result


puts '------------------------------------'
pp (0..25).map {|x| x**2}.each_cons(2).map {|(a,b)| b - a }.to_a
