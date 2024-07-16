# Totient permutation
# https://projecteuler.net/problem=70

# Euler's Totient function, φ(n) [sometimes called the phi function], is used to determine the number of positive numbers less than or equal to n which are relatively prime to n. For example, as 1, 2, 4, 5, 7, and 8, are all less than nine and relatively prime to nine, φ(9)=6.
# The number 1 is considered to be relatively prime to every positive number, so φ(1)=1.

# Interestingly, φ(87109)=79180, and it can be seen that 87109 is a permutation of 79180.

# Find the value of n, 1 < n < 10^7, for which φ(n) is a permutation of n and the ratio n/φ(n) produces a minimum.

require 'prime'

def factors(n)
  @factors ||= {}

  @factors[n] || n.prime_division.map(&:first)
end

def phi(n)
  n.prime_division.reduce(1) { |r,(p, a)| r * (p - 1) * (p ** (a-1)) }
end

puts (2...10**7).min_by { |n|
  print '.' if n % 10_000 == 0
# (2..100).each { |n|
  p = phi(n)

  if n.digits.sort != p.digits.sort
    Float::INFINITY
  else
    Rational(n)/p
  end
  # puts "n=#{n}, φ(n)=#{count}, n/φ(n)=#{ratio}"
  # puts "n=#{n}, φ(n)=#{count}, new_φ(n)=#{}"
  # puts "n=#{n}, φ(  n)=#{count}, n/φ(n)=#{Rational(n)/count}  #{n.to_f/count}"
}
