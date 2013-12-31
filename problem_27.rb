=begin
Euler discovered the remarkable quadratic formula:

n² + n + 41

It turns out that the formula will produce 40 primes for the consecutive values n = 0 to 39. However, when n = 40, 402 + 40 + 41 = 40(40 + 1) + 41 is divisible by 41, and certainly when n = 41, 41² + 41 + 41 is clearly divisible by 41.

The incredible formula  n² − 79n + 1601 was discovered, which produces 80 primes for the consecutive values n = 0 to 79. The product of the coefficients, −79 and 1601, is −126479.

Considering quadratics of the form:

n² + an + b, where |a| < 1000 and |b| < 1000

where |n| is the modulus/absolute value of n
e.g. |11| = 11 and |−4| = 4
Find the product of the coefficients, a and b, for the quadratic expression that produces the maximum number of primes for consecutive values of n, starting with n = 0.
=end

require 'prime'

nums = (-999..999).select(&:odd?)
pairs = nums.product(nums)

max_a = nil
max_b = nil
max_primes = 0

pairs.each do |a, b|
  n = 0
  n += 1 while Prime.instance.prime?(((n + a) * n) + b)
  if n > max_primes
    max_a = a
    max_b = b
    max_primes = n
  end
end

puts "a: #{max_a}  b: #{max_b}  consecutive: #{max_primes}\nanswer: #{max_a * max_b}"
