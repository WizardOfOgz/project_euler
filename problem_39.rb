=begin
If p is the perimeter of a right angle triangle with integral length sides, {a,b,c}, there are exactly three solutions for p = 120.

{20,48,52}, {24,45,51}, {30,40,50}

For which value of p ≤ 1000, is the number of solutions maximised?
=end

# x + y + z = p
# x^2 + y^2 = z^2

# z = p - x - y
# z = (x^2 + y^2)^(1/2)

# (x^2 + y^2)^(1/2) = p - x - y
# x^2 + y^2 = (p - x - y)^2
#           = p^2 - px - py - px + x^2 + xy - py + xy + y^2
#           = p^2 - 2px - 2py + x^2 + 2xy + y^2
# 0 = p^2 - 2px - 2py + 2xy
#   = p(p - 2x) + 2y(x - p)
# 2y(x - p) = p(p - 2x)
#        2y = p(p-2x) / (x - p)
#         y = p(p - 2x) / (2(x - p))


require 'set'

squares = Enumerator.new(Float::INFINITY) do |yielder|
  x = 1
  loop do
    yielder << x ** 2
    x += 1
  end
end

valid_squares = squares.take_while{|x| x < 1_000_000 }

results = {}

squares.lazy.take_while{|n| n < 1_000_000 }.each do |x|
  squares.lazy.take_while{|n| n < 1_000_000 }.each do |y|
    break if x + y > 1_000_000
    if square = valid_squares.bsearch{|i| x + y <=> i }
      sum = Math.sqrt(x).to_i + Math.sqrt(y).to_i  + Math.sqrt(square).to_i
      next if sum > 1_000
      results[sum] ||= Set.new
      results[sum] << [x, y].sort
    end
  end
end

result = results.sort_by{|key, sets| sets.length }.last

puts result.inspect
