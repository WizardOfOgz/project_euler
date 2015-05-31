=begin
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once. For example, 2143 is a 4-digit pandigital and is also prime.

What is the largest n-digit pandigital prime that exists?
=end

require 'prime'

# Depth-first search starting with largest number and working down towards the first pandigital prime
def pe41(digits = [], pool = (1..7).to_a.reverse)
# puts "#{digits.inspect} :: #{pool.inspect}"
  if pool.empty?
    candidate = digits.join.to_i
    return candidate.prime? ? candidate : nil
  else
    pool.each do |digit|
      result = pe41(digits + [digit], pool - [digit])
      if result
      # if result = pe41(digits + [digit], pool - [digit])
        return result
      end
    end
  end

  nil  # No result found
end

t0 = Time.now
(1..7).to_a.reverse.each do |max|  # Max number of digits is 7 because the numbers made from digits 1-9 and 1-8 are always divisible by 3
  result = pe41([], (1..max).to_a.reverse)
  if result
    puts result
    break
  end
end
t1 = Time.now

puts t1 - t0
