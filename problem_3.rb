# Largest prime factor
# https://projecteuler.net/problem=3

# The prime factors of 13195 are 5, 7, 13 and 29.

# What is the largest prime factor of the number 600851475143 ?

require 'prime'


def prime_factors(n)
  primes = Prime.lazy
  factors = []
  r = n
  while (p = primes.next) <= Math.sqrt(r)
    pp "> #{p}"
    while r % p == 0
      factors << p
      r /= p
    end
  end
  factors << r

  factors.uniq
end

# pp prime_factors(13)
# pp prime_factors(20)
# pp prime_factors(13195)
# pp prime_factors(600851475143)
pp prime_factors(600851475143).max
