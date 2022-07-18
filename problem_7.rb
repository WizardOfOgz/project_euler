# 10001st prime
# https://projecteuler.net/problem=7

require 'prime'
pp Prime.lazy.drop(10_000).first
