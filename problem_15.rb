# Lattice paths
# https://projecteuler.net/problem=15

# Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.

# How many such routes are there through a 20×20 grid?

# 1 1 1  1
# 1 2 3  4
# 1 3 6  10
# 1 4 10 20

pascal_triangle = Enumerator.new do |yielder|
  yielder << [1]
  row = [1, 1]
  yielder << row
  loop do
    row = [1, *row.each_cons(2).map { |(a,b)| a + b }, 1]
    yielder << row
  end
end

# 1 2
#   3 4
#     5

# The bottom corner of an n x n grid will be the center value (max) of row 2n + 1 in Pascal's triangle

pp pascal_triangle.lazy.drop(40).first.max
