# Totient maximum
# https://projecteuler.net/problem=69


# Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of numbers less than n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
# n 	Relatively Prime 	φ(n) 	n/φ(n)
# 2 	1 	1 	2
# 3 	1,2 	2 	1.5
# 4 	1,3 	2 	2
# 5 	1,2,3,4 	4 	1.25
# 6 	1,5 	2 	3
# 7 	1,2,3,4,5,6 	6 	1.1666...
# 8 	1,3,5,7 	4 	2
# 9 	1,2,4,5,7,8 	6 	1.5
# 10 	1,3,7,9 	4 	2.5

# It can be seen that n=6 produces a maximum n/φ(n) for n ≤ 10.

# Find the value of n ≤ 1,000,000 for which n/φ(n) is a maximum.

require 'prime'

def factors(n)
  @factors ||= {}

  @factors[n] || n.prime_division.map(&:first)
end

def phi(n)
  # puts "phi(#{n})"
  if n.prime?
    n - 1
  else
    factor, count = n.prime_division.first
    # puts "factor: #{factor}, count: #{count}"
    multiplier = (count > 1) ? factor : factor - 1
    multiplier * phi(n / factor)
  end
end

puts (2..1_000_000).max_by { |n|
# (2..100).each { |n|
  count, rel_primes = phi(n)
  ratio = Rational(n)/count
  # puts "n=#{n}, φ(n)=#{count}, n/φ(n)=#{ratio}"
  puts "n=#{n}, φ(n)=#{count}"
  # puts "n=#{n}, φ(  n)=#{count}, n/φ(n)=#{Rational(n)/count}  #{n.to_f/count}"
}

__END__

n = 125  φ(125) = 100
n = 25   φ(25) = 20
n = 5    φ(5) = 4

n=5, φ(n)=4
n=25, φ(n)=20    5x n=5
n=35, φ(n)=24    4x n=7
n=55, φ(n)=40    4x
n=65, φ(n)=48    4x
n=85, φ(n)=64    4x
n=95, φ(n)=72    4x
n=115, φ(n)=88   4x
n=125, φ(n)=100  5x
n=145, φ(29)=112  4x

n=30, φ(n)=8   same as n=15
n=32, φ(n)=16  2x n=16
n=34, φ(n)=16  same as n=17
n=36, φ(n)=12  2x n=18

n=9, φ(n)=6   3x n=3
n=15, φ(n)=8  2x n=5
n=21, φ(n)=12 2x n=7
n=27, φ(n)=18 3x n=9
n=33, φ(n)=20 2x n=11
n=39, φ(n)=24 2x n=13
n=45, φ(n)=24 3x n=15
