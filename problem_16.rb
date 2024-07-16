# Power digit sum
# https://projecteuler.net/problem=16

# 2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

# What is the sum of the digits of the number 2^1000?

# The question was probably intended to force the user to use extended precision multiplication,
# which is fairly trivial. And for many modern languages, that is handled transparently.
pp (2**1_000).digits.sum
