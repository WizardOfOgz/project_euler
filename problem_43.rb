=begin
The number, 1406357289, is a 0 to 9 pandigital number because it is made up of each of the digits 0 to 9 in some order, but it also has a rather interesting sub-string divisibility property.

Let d1 be the 1st digit, d2 be the 2nd digit, and so on. In this way, we note the following:

d2d3d4=406 is divisible by 2
d3d4d5=063 is divisible by 3
d4d5d6=635 is divisible by 5
d5d6d7=357 is divisible by 7
d6d7d8=572 is divisible by 11
d7d8d9=728 is divisible by 13
d8d9d10=289 is divisible by 17
Find the sum of all 0 to 9 pandigital numbers with this property.
=end

=begin
  d4 must be even
  d6 must be either 0 or 5
  Ranges d1-d5 and d7-d10 must contain exactly one of 0 or 5.
=end

# Sets of possible numbers at the corresponding positions
r2 = (0..999).step(2).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.reject{|digits| %w[0 5].all?{|digit| digits.include?(digit) } }
r3 = (0..999).step(3).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.reject{|digits| %w[0 5].all?{|digit| digits.include?(digit) } }
r5 = (0..999).step(5).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }
r7 = (0..999).step(7).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.select{|digits| %w[0 5].include?(digits[1]) }     # Middle digit must be 0 or 5 (this set has the second fewest options)
r11 = (0..999).step(11).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.select{|digits| %w[0 5].include?(digits[0]) }   # First digit must be 0 or 5  (this set has the fewest options)
r13 = (0..999).step(13).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.reject{|digits| %w[0 5].all?{|digit| digits.include?(digit) } }
r17 = (0..999).step(17).map{|x| "%03i" % x }.select{|x| x.split('').uniq.length == 3 }.reject{|digits| %w[0 5].all?{|digit| digits.include?(digit) } }

%w[2 3 5 7 11 13 17].each do |r|
  puts "R#{r}: " + eval("r#{r}.length").to_s
end

matching_pandigitals = []

t0 = Time.now
r11.each do |r11_digits|
  r11_remaining_digits = %w[0 1 2 3 4 5 6 7 8 9] - r11_digits.split('')

  r7.select{|r7_digits| r7_digits[1..2] == r11_digits[0..1] && r11_remaining_digits.include?(r7_digits[0]) }.each do |r7_digits|
    r7_remaining_digits = r11_remaining_digits - r7_digits.split('')

    r13.select{|r13_digits| r13_digits[0..1] == r11_digits[1..2] && r7_remaining_digits.include?(r13_digits[2]) }.each do |r13_digits|
      r13_remaining_digits = r7_remaining_digits - r13_digits.split('')

      r17.select{|r17_digits| r17_digits[0..1] == r13_digits[1..2] && r13_remaining_digits.include?(r17_digits[2]) }.each do |r17_digits|
        r17_remaining_digits = r13_remaining_digits - r17_digits.split('')

        r5.select{|r5_digits| r5_digits[1..2] == r7_digits[0..1] && r17_remaining_digits.include?(r5_digits[0]) }.each do |r5_digits|
          r5_remaining_digits = r17_remaining_digits - r5_digits.split('')

          r3.select{|r3_digits| r3_digits[1..2] == r5_digits[0..1] && r5_remaining_digits.include?(r3_digits[0]) }.each do |r3_digits|
            r3_remaining_digits = r5_remaining_digits - r3_digits.split('')

            r2.select{|r2_digits| r2_digits[1..2] == r3_digits[0..1] && r3_remaining_digits.include?(r2_digits[0]) }.each do |r2_digits|
              r2_remaining_digits = r3_remaining_digits - r2_digits.split('')

              matching_pandigitals << (r2_remaining_digits.join + r2_digits + [r3_digits, r5_digits, r7_digits, r11_digits, r13_digits, r17_digits].map{|digits| digits[-1]}.join)  # Join all the digits together to form the pandigital
            end
          end
        end
      end
    end
  end
end

# matching_pandigitals.each{|x| puts x}

puts "#{matching_pandigitals.map(&:to_i).inject(&:+)} (#{Time.now - t0}s)"
puts matching_pandigitals.map(&:to_i).inject(&:+)
