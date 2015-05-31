=begin
The nth term of the sequence of triangle numbers is given by, tn = ½n(n+1); so the first ten triangle numbers are:

1, 3, 6, 10, 15, 21, 28, 36, 45, 55, ...

By converting each letter in a word to a number corresponding to its alphabetical position and adding these values we form a word value. For example, the word value for SKY is 19 + 11 + 25 = 55 = t10. If the word value is a triangle number then we shall call the word a triangle word.

Using words.txt (right click and 'Save Link/Target As...'), a 16K text file containing nearly two-thousand common English words, how many are triangle words?
=end

words = File.read('resources/problem_41-words.txt').split(/[",]+/)


class Euler42
  def self.is_triangle?(n)
    # Generate any needed triangle numbers
    @triangle_numbers ||= [1]
    @triangle_numbers << ((@triangle_numbers.length + 1) * (@triangle_numbers.length + 2) / 2) while @triangle_numbers.last < n

    !!@triangle_numbers.bsearch{|i| n <=> i }
  end
end

triangle_words_count = words.count do |word|
  val = word.bytes.map{|x| x - 64 }.inject(&:+)
# puts "\"#{word}\" #{val} (#{val && Euler42.is_triangle?(val)})"
  val && Euler42.is_triangle?(val)
end

puts triangle_words_count
