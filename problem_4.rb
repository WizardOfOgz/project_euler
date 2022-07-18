# Largest palindrome product
# https://projecteuler.net/problem=4

# A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.

# Find the largest palindrome made from the product of two 3-digit numbers.

load 'utils/palindrome.rb'

pp (999..100).step(-1).to_a
  .repeated_combination(2)
  .lazy
  .map { |(a,b)| a*b }
  .select { |n| n.to_s.is_palindrome? }
  .max
