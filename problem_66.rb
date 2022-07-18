# Diophantine equation

def reduce_continued_fractions(continued_fraction)
  a0, args =
  args.reverse.reduce([1, 0]) do |(num, den), arg|
    r = [arg * num + den, num]
    # puts [arg, num, den, r].inspect
    # puts r.inspect
    r
  end
end


load 'utils/gcd.rb'
require 'set'

### Borrowed from p64
def continued_fraction(square_number)
  k = square_number
  d = 1
  a = a0 = ((Math.sqrt(k) - 0) / d).floor
  r = -a

  period_set = []

  loop do
    d_sub = k - r ** 2

    r_prime = -r
    d_prime = k - r_prime ** 2
    a_prime = (d * ((Math.sqrt(k) + r_prime)) / d_prime).floor

    # Simplify the
    gcd_d_d_prime = Utils.gcd(d, d_prime)
    num = d / gcd_d_d_prime
    den = d_prime / gcd_d_d_prime

    new_r = r_prime - a_prime * den

    a = a_prime
    d = den
    r = new_r

    period_values = { a:, d:, r: }

    # pp(period_values)

    break if period_set.include?(period_values)
    period_set << period_values
  end

  [a0, period_set.map {|p| p[:a] }]
end

def repeat(args)
  Enumerator.new do |yielder|
    i = 0
    loop do
      yielder << args[i]
      i = (i + 1) % args.size
    end
  end
end

def convergents(continued_periodic_fraction)
  a0, period = continued_periodic_fraction
  num_1 = 1
  den_1 = 0
  num = a0
  den = 1
  Enumerator.new do |yielder|
    yielder << Rational(num, den)
    repeat(period).each do |a|
      n = a * num + num_1
      d = a * den + den_1
      yielder << Rational(n, d)

      num_1 = num
      den_1 = den
      num = n
      den = d
    end
  end
end

# a0/1, a1a0 + 1/a1, a2(a1a0 + 1) + a0/a2a1 + 1, a3(a2(a1a0 + 1) + a0) + (a1a0 + 1)/ a3(a2a1 + 1) + a1.

result = (2..1_000).lazy
  .select { |n| Integer.sqrt(n) ** 2 != n } # keep only numbers which are not perfect squares
  .map { |n| [n, convergents(continued_fraction(n)).find { |r| r.numerator**2 - (n * r.denominator ** 2) == 1 }] }
  .max_by { |(n, r)| r.numerator }

puts result
