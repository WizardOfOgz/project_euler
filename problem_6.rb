# Sum square difference
# https://projecteuler.net/problem=6

pp ((1..100).sum ** 2) - ((1..100).map {|m| m**2}.sum)
