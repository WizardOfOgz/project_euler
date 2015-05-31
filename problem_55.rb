RubyVM::InstructionSequence.compile_option = {
  tailcall_optimization: true,
  trace_instruction: false
}

# s = "abcdcb"; puts "#{ s }: #{ palindrome?(s) }"
# s = "abba"; puts "#{ s }: #{ palindrome?(s) }"
# s = "a"; puts "#{ s }: #{ palindrome?(s) }"
def palindrome?(s)
  i = 0
  while i < s.length - i
    return false if s[i] != s[-i - 1]
    i += 1
  end
  true
end

def lychrel?(n, iter = 1)
  return true if iter >= 50
  m = n.to_s.reverse.to_i
  r = n + m
  palindrome?(r.to_s) ? false : lychrel?(r, iter + 1)
end

# puts lychrel?(47)
# puts lychrel?(349)
# puts lychrel?(4994)

puts lychrel?(196)
puts lychrel?(10677)

lychrel_count = 0
(1...10_000).each { |n| lychrel_count += 1 if lychrel?(n) }
puts lychrel_count

# def p?(s)
#   (0..s.length/2).all? { |i| s[i] == s[-i - 1] }
# end

# s = "abcdefgfedcba".freeze
# s2 = "abcdefgfedcbaz".freeze
#
#
# t0 = Time.now; 1000.times { palindrome?(s); palindrome?(s2) }; puts t0 - Time.now
# t0 = Time.now; 1000.times { p?(s); p?(s2) }; puts t0 - Time.now
