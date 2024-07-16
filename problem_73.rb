# Counting fractions in a range
# https://projecteuler.net/problem=73

# Consider the fraction, n/d, where n and d are positive integers. If n<d and HCF(n,d)=1, it is called a reduced proper fraction.

# If we list the set of reduced proper fractions for d ≤ 8 in ascending order of size, we get:

# 1/8, 1/7, 1/6, 1/5, 1/4, 2/7, 1/3, 3/8, 2/5, 3/7, 1/2, 4/7, 3/5, 5/8, 2/3, 5/7, 3/4, 4/5, 5/6, 6/7, 7/8

# It can be seen that there are 3 fractions between 1/3 and 1/2.

# How many fractions lie between 1/3 and 1/2 in the sorted set of reduced proper fractions for d ≤ 12,000?


load 'utils/prime.rb' # Integer#relatively_prime?

# For each d find all n such that 1/3 < n/d < 1/2

e = Enumerator.new do |yielder|
  range = (5..12_000)
  # range = ((5..1000)) #.lazy.reject { |d| d % 3 == 0 }

  range.each do |d|
    n_min = Rational(d, 3).ceil
    n_max = Rational(d, 2).floor

    # puts <<~EOS
    #   d=#{d}, n_min=#{n_min}, n_max=#{n_max}
    # EOS

    (n_min..n_max).each do |n|

      # puts "> n=#{n} #{d.relatively_prime?(n)}"
      yielder << Rational(n, d) if d.relatively_prime?(n)
    end
  end
end

puts e.count
