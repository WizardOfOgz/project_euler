# Ordered fractions
# https://projecteuler.net/problem=71

# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.

# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

# It can be seen that 2/5 is the fraction immediately to the left of 3/7.

# By listing the set of reduced proper fractions for d ≤ 1,000,000 in ascending order of size, find the numerator of the fraction immediately to the left of 3/7.

###


# For each d
# • Skip if it is a multiple of 7
# • Start with the nearest fraction to 3/7 with denominator d which is < 3/7

load 'utils/prime.rb'
load 'utils/gcd.rb'  # Integer#gcd

# range = (1..100)
range = (1..1_000_000)

target = Rational(3, 7)

num = range.lazy
  .reject { |d| d % target.denominator == 0 }
  .map { |d| [d, (target.numerator * Rational(d, 7)).floor] }
  .min_by do |d, n|

    if n.gcd(d) > 1
      Float::INFINITY
    else
      nearest = Rational(n, d)
      target - nearest
    end
  end


pp num
