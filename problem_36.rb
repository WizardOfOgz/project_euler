=begin
The decimal number, 585 = 1001001001 (binary), is palindromic in both bases.

Find the sum of all numbers, less than one million, which are palindromic in base 10 and base 2.

(Please note that the palindromic number, in either base, may not include leading zeros.)
=end

def is_palindrome(s)
  head_pos = ((s.length - 1) / 2).floor
  tail_pos = ((s.length) / 2).floor

  while head_pos >= 0
    return false unless s[head_pos] == s[tail_pos]
    head_pos -= 1
    tail_pos += 1
  end

  return true
end

t0 = Time.now
sum = 0
(1..999_999).step(2).each do |x|
  if is_palindrome(x.to_s) && is_palindrome(x.to_s(2))
    puts x
    sum += x
  end
end
t1 = Time.now

puts "TOTAL: #{sum} (#{t1 - t0}s)"
