# Smallest multiple
# https://projecteuler.net/problem=5

# 2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

# What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

require 'prime'
pp (1..20)
  .flat_map(&:prime_division)
  .group_by { |(factor, count)| factor }
  .map { |factor, factors| factor ** factors.map { |factor, count| count }.max }
  .reduce(&:*)
