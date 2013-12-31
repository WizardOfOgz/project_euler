=begin
145 is a curious number, as 1! + 4! + 5! = 1 + 24 + 120 = 145.

Find the sum of all numbers which are equal to the sum of the factorial of their digits.

Note: as 1! = 1 and 2! = 2 are not sums they are not included.
=end

def fac(n)
  n == 0 ? 1 : n * fac(n - 1)
end

factorials = (0..9).inject({}){|facs, x| facs[x.to_s] = fac(x); facs }
curious_numbers = []

(3..2540160).each do |n|  # 2540160 is the maximum value at which a number can be represented by the sum of the factorials of its digits (9! * 7)
puts "(#{n})"
  if n.to_s.split('').map{|x| factorials[x] }.inject(&:+) == n
    curious_numbers << n
    puts n
  end
end

puts "Sum of curious numbers: #{curious_numbers.inject(&:+)}"
