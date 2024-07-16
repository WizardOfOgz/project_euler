# Special Pythagorean triplet
# https://projecteuler.net/problem=9


# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
# a2 + b2 = c2

# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

e = Enumerator.new do |yielder|
  (1..332).lazy.each do |a| # a cannot be greater than 332 due to the conditions a < b < c, and a + b + c = 1,000
    # b can only be maximized if a is minimized (i.e. a = 1), when a = 1 then b + c = 1_000 - 1 = 999.
    # Since b < c, b cannot be greater than 499.
    (a+1...499).lazy.each do |b|
      # c = (b+1...997).find do |c| # If a and b are minimized, i.e. a = 1 and b = 2, then c has a maximum value of 997.
      c = 1_000 - b - a
      yielder << [a, b, c] if a ** 2 + b ** 2 == c ** 2
    end
  end
end

a, b, c = e.next # Get the first (and known to be the only) pythagorean triplet where a + b + c = 1,000

pp a * b * c
