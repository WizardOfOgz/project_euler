require 'prime'
require 'bigdecimal'

# 4 * 2n
# 1 + n(n+1)/2 -- -(m * n), m = {0,1,2,3}
# 0 1 3 6 10
primes_count = 0
total = 1

n = 1
loop do
  # Next corners
  c = 1 + 8 * (n * (n + 1) / 2)
  short_side_length = n * 2

  4.times do
# puts c
    primes_count += 1 if c.prime?
    c -= short_side_length
  end
  total += 4

# print "\r#{ primes_count } / #{ total } = #{ (primes_count / BigDecimal(total)) }"

  break if (primes_count / BigDecimal(total)) < BigDecimal("0.10")
  n += 1
end

puts "\n", (2 * n) + 1



# puts (0..4).map{|n| (n * (n + 1) / 2) }.map{|x| 8 * x + 1 }.inspect
