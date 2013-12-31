=begin
The number, 197, is called a circular prime because all rotations of the digits: 197, 971, and 719, are themselves prime.

There are thirteen such primes below 100: 2, 3, 5, 7, 11, 13, 17, 31, 37, 71, 73, 79, and 97.

How many circular primes are there below one million?
=end

require 'prime'
require 'set'

# circular_primes = Set.new

# Prime.instance.take_while{|x| x < 1_000_000 }.each do |x|
#   next if circular_primes.include?(x)
#   digits = x.to_s.split('')
#   all_prime = true

#   candidates = (0...digits.length).map do |n|
#     digits.rotate(n).join.to_i
#   end

#   candidates.each do |candidate|
#     all_prime &= Prime.instance.prime?(candidate)
#   end

#   if all_prime
#     candidates.each do |candidate|
#       circular_primes << candidate
#       puts candidate
#     end
#   end
# end

# puts "TOTAL: #{circular_primes.count}"


circular_primes = Set.new([2,3,5,7])  # Start with single digit primes

Prime.instance.take_while{|x| x < 1_000_000 }.each do |x|
  next if circular_primes.include?(x)
  digits = x.to_s.split('')
  next unless digits.all?{|digit| %w[1 3 7 9].include?(digit) }
  all_prime = true

  candidates = (0...digits.length).map do |n|
    digits.rotate(n).join.to_i
  end

  candidates.each do |candidate|
    all_prime &= Prime.instance.prime?(candidate)
  end

  if all_prime
    candidates.each do |candidate|
      circular_primes << candidate
      puts candidate
    end
  end
end

puts "TOTAL: #{circular_primes.count}"