# Special Pythagorean triplet
# https://projecteuler.net/problem=9


# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
# a2 + b2 = c2

# For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

require 'benchmark/ips'

NUM_WORKERS = 100

pipe = Ractor.new do
  loop do
    Ractor.yield Ractor.receive
  end
end

workers = NUM_WORKERS.times.map do
  Ractor.new(pipe) do |pipe|
    while (a, b = pipe.take)
      Ractor.yield [a, b, (1_000 - b - a)] if a ** 2 + b ** 2 == (1_000 - b - a) ** 2
    end
  end
end


(1..332).each do |a| # a cannot be greater than 332 due to the conditions a < b < c, and a + b + c = 1,000
  # b can only be maximized if a is minimized (i.e. a = 1), when a = 1 then b + c = 1_000 - 1 = 999.
  # Since b < c, b cannot be greater than 499.
  (a+1...499).each do |b|
    pipe << [a, b]
  end
end

_ractor, (a, b, c) = Ractor.select(*workers)
pp a * b * c

(1..332).each do |a| # a cannot be greater than 332 due to the conditions a < b < c, and a + b + c = 1,000
  # b can only be maximized if a is minimized (i.e. a = 1), when a = 1 then b + c = 1_000 - 1 = 999.
  # Since b < c, b cannot be greater than 499.
  (a+1...499).each do |b|
    pipe << [a, b]
  end
end

_ractor, (a, b, c) = Ractor.select(*workers)


Benchmark.ips do |x|
  x.report do
    (1..332).each do |a| # a cannot be greater than 332 due to the conditions a < b < c, and a + b + c = 1,000
      # b can only be maximized if a is minimized (i.e. a = 1), when a = 1 then b + c = 1_000 - 1 = 999.
      # Since b < c, b cannot be greater than 499.
      (a+1...499).each do |b|
        pipe << [a, b]
      end
    end

    _ractor, (a, b, c) = Ractor.select(*workers)
  end
end

pp a * b * c
