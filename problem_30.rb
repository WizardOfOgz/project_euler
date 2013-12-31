=begin
Surprisingly there are only three numbers that can be written as the sum of fourth powers of their digits:

1634 = 14 + 64 + 34 + 44
8208 = 84 + 24 + 04 + 84
9474 = 94 + 44 + 74 + 44
As 1 = 14 is not a sum it is not included.

The sum of these numbers is 1634 + 8208 + 9474 = 19316.

Find the sum of all the numbers that can be written as the sum of fifth powers of their digits.
=end

n = 3
numbers = []

while n < 1000000  # 7-digit numbers can not be expressed as sums of their digits to the 5th power because 1000000 > (7 * 9^5)
  if n.to_s.split('').map{|s| s.to_i ** 5 }.inject(&:+) == n
    numbers << n
    puts "#{n} - Sum: #{numbers.inject(&:+)}"
  end
  n += 1
end
