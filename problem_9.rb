# Special Pythagorean triplet
# https://projecteuler.net/problem=9

triplet = (1..1000).to_a
  .repeated_combination(3)
  .lazy
  .select { |(a,b,c)| a + b + c == 1_000 }
  .select { |(a,b,c)| a ** 2 + b ** 2 == c ** 2 }
  .first

pp triplet.reduce(&:*)
