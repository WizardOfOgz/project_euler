# Multiples of 3 or 5
# https://projecteuler.net/problem=1

puts (1...1000)
  .select { |n| n % 3 == 0 || n % 5 == 0 }
  .sum
