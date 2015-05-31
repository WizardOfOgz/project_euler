require "prime"
#
# def prime_sum(sum = 0, primes = Prime.take(4920)) #_while { |n| @last ||= 0; overflow = (@last + n) < 1_000_000; @last = n; overflow; })
#   (1..primes.length).to_a.reverse.each do |len|
# # print "\nLength #{len}"
#     (0...primes.length - len).each do |i|
#       subsum = primes.slice(i, len).inject(:+)
# # puts subsum
# # print "."
#       if subsum < 1_000_000
#         return subsum if subsum.prime?
#       else
#         break
#       end
#     end
#   end
# end
#
# puts prime_sum


def prime_sum(sum = 0, primes = Prime.take_while { |n| @last ||= 0; overflow = (@last + n) < 1_000_000; @last = n; overflow; })
  best = 0
  last = 0

  (1..primes.length).to_a.each do |len|
# print "\rLength: #{ len }, Best: #{ best }"
    (0...primes.length - len).each do |i|
      # subsum = primes.slice(i, len).inject(:+)
      subsum = 0
      len.times do |j|
        subsum += primes[i + len - j]
        break unless subsum < 1_000_000
      end
      if subsum < 1_000_000
        if subsum.prime?
          best = len
          last = subsum
          break
        end
      else
        break
      end
    end
  end
  last
end

puts prime_sum
