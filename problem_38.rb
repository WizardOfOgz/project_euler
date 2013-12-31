=begin
Take the number 192 and multiply it by each of 1, 2, and 3:

192 × 1 = 192
192 × 2 = 384
192 × 3 = 576
By concatenating each product we get the 1 to 9 pandigital, 192384576. We will call 192384576 the concatenated product of 192 and (1,2,3)

The same can be achieved by starting with 9 and multiplying by 1, 2, 3, 4, and 5, giving the pandigital, 918273645, which is the concatenated product of 9 and (1,2,3,4,5).

What is the largest 1 to 9 pandigital 9-digit number that can be formed as the concatenated product of an integer with (1,2, ... , n) where n > 1?
=end

i = 1
largest = 0

t0 = Time.now
while i < 10000
  digits = []
  x = 1
  while digits.length < 9
    (i * x).to_s.split('').each do |digit|
      digits << digit
    end
    x += 1
  end

  if digits.sort == %w[1 2 3 4 5 6 7 8 9]
    pandigital = digits.join.to_i
# puts "#{pandigital} (#{largest})"
    largest = pandigital if pandigital > largest
  end

  i += 1
end
t1 = Time.now

puts "#{largest} (#{t1 - t0}s)"
