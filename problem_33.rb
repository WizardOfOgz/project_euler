=begin
The fraction 49/98 is a curious fraction, as an inexperienced mathematician in attempting to simplify it may incorrectly believe that 49/98 = 4/8, which is correct, is obtained by cancelling the 9s.

We shall consider fractions like, 30/50 = 3/5, to be trivial examples.

There are exactly four non-trivial examples of this type of fraction, less than one in value, and containing two digits in the numerator and denominator.

If the product of these four fractions is given in its lowest common terms, find the value of the denominator.
=end

require 'prime'

pairs = []

t0 = Time.now
(1..9).each do |cancel_digit|
  (1..9).each do |numerator_digit|
    next if numerator_digit == cancel_digit
    (1..9).each do |denominator_digit|
      next if denominator_digit == cancel_digit || numerator_digit == denominator_digit
      target = (numerator_digit/denominator_digit.to_f)

      [
        [numerator_digit, cancel_digit, cancel_digit, denominator_digit],
        [numerator_digit, cancel_digit, denominator_digit, cancel_digit],
        [cancel_digit, numerator_digit, cancel_digit, denominator_digit],
        [cancel_digit, numerator_digit, denominator_digit, cancel_digit],
      ].each do |n1, n2, d1, d2|


        numerator = (n1 * 10) + n2
        denominator = (d1 * 10) + d2

        if numerator < denominator && (numerator/denominator.to_f) == target
          pairs << [numerator, denominator]
          puts [numerator, denominator].inspect
        end
      end
    end
  end
end
t1 = Time.now

product_numerator = 1
product_denominator = 1

pairs.each do |num, den|
  product_numerator *= num
  product_denominator *= den
end

numerator_prime_factors = Prime.take_while{|x| x < Math.sqrt(product_numerator) }.select{|x| product_numerator % x == 0 }
denominator_prime_factors = Prime.take_while{|x| x < Math.sqrt(product_denominator) }.select{|x| product_denominator % x == 0 }
# puts [product_numerator, product_denominator].inspect

common_prime_factors = numerator_prime_factors & denominator_prime_factors

common_prime_factors.each do |factor|
  while (product_numerator % factor == 0) && (product_denominator % factor == 0)
    product_numerator /= factor
    product_denominator /= factor
# puts [product_numerator, product_denominator].inspect
  end
end
t2 = Time.now

puts "#{[product_numerator, product_denominator].inspect} (#{t1 - t0} + #{t2 - t1} : #{t2 - t0})"
