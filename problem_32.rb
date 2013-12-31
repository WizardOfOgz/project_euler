=begin
We shall say that an n-digit number is pandigital if it makes use of all the digits 1 to n exactly once; for example, the 5-digit number, 15234, is 1 through 5 pandigital.

The product 7254 is unusual, as the identity, 39 × 186 = 7254, containing multiplicand, multiplier, and product is 1 through 9 pandigital.

Find the sum of all products whose multiplicand/multiplier/product identity can be written as a 1 through 9 pandigital.

HINT: Some products can be obtained in more than one way so be sure to only include it once in your sum.
=end

require 'set'

digits = (1..9).map(&:to_s).freeze

# candidates = (1..4).map{|x| digits.permutation(x).to_a}.inject(&:+)  # A term may be no more than 4 digits in length

pandigital_products = Set.new  # Sets avoid duplicates

# candidates.each do |candidate|
#   remaining_digits = digits - candidate
#   max_multiplier_length = remaining_digits.length - candidate.length
#   multiplier_candidates = (1..max_multiplier_length).map{|x| remaining_digits.permutation(x).to_a}.inject(&:+)

#   multiplier_candidates.each do |multiplier|
#     product = (candidate.join.to_i * multiplier.join.to_i)
#     # puts "#{candidate.join} * #{multiplier.join} = #{product}"
#     if product.to_s.split('').sort == (remaining_digits - multiplier).sort
#       pandigital_products << product
#       puts "#{candidate.join.to_i} * #{multiplier.join.to_i} = #{product}"
#     end
#   end
# end

# puts "PRODUCT SUM: #{pandigital_products.inject(&:+)}"

(1..9876).each do |multiplicand|
  (1...[9877, (10 ** (9 - multiplicand.to_s.split('').length))].min).each do |multiplier|
    product = multiplicand * multiplier
# puts "#{multiplicand} * #{multiplier} = #{product}"
    if "#{multiplicand}#{multiplier}#{product}".split('').sort == digits
      pandigital_products << product
      puts "#{multiplicand.to_i} * #{multiplier.to_i} = #{product}"
    end
  end
end

puts "PRODUCT SUM: #{pandigital_products.inject(&:+)}"
