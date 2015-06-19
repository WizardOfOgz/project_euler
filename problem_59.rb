encrypted = File.read("resources/problem_59_cipher.txt").scan(/\d+/).map(&:to_i)

# result = ('a'.unpack('c').first..'z'.unpack('c').first).to_a.repeated_permutation(3).lazy.
#   map { |key|
#     decrypted = encrypted.lazy.each_slice(3).flat_map do |ecodes|
#       dcodes = ecodes.zip(key).map do |e, k|
#         e ^ k
#       end
#     end
#     decrypted_text = decrypted.to_a.pack("c*")
#     decrypted if %w[the in that].all? {|term| decrypted_text.include?(term) }
#   }.
#   detect(&:itself)
#
# puts "\n-------------\n#{ result.inject(:+) }"

frequencies = [Hash.new(0), Hash.new(0), Hash.new(0)]
encrypted.each_with_index { |c, idx| frequencies[idx % 3][c] += 1 }
encrypted_spaces = frequencies.map {|_frequencies| _frequencies.max {|(k,v), (k2,v2)| v <=> v2 }.first }
key = encrypted_spaces.map {|k| k ^ 32 }
puts encrypted.each_slice(3).flat_map { |triplet| triplet.each_with_index.map {|e, idx| e ^ key[idx] } }.inject(:+)#.pack("c*")
