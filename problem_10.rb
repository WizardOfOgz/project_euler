# Summation of primes
# https://projecteuler.net/problem=10

# The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

# Find the sum of all the primes below two million.

require 'prime'

pp Prime.lazy.take_while { |n| n < 2_000_000 }.sum
