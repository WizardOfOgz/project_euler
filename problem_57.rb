def _iter(n)
  Rational(1, n == 1 ? 2 : (2 + _iter(n - 1)))
end

def iter(n)
  x = 1 + _iter(n)
  x.numerator.to_s.split("").length > x.denominator.to_s.split("").length
end

puts (1..1000).select { |x| iter(x) }.length
