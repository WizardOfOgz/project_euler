require 'prime'
# def masks(n)
#   Enumerator.new do |yielder|
#     # (2..n).each do |i|
#       [:x, :o].repeated_permutation(n).lazy.reject {|v| v.uniq.one? }.each do |mask|
#         yielder << mask
#       end
#     # end
#   end
# end

# puts masks(4).to_a.inspect

# (2..5).each {|x| puts masks(x).to_a.length  }
LEN = 8
results = Enumerator.new do |yielder|
  num_digits = 2
  loop do
    [:x, "%i"].repeated_permutation(num_digits).lazy
      .reject { |placeholders| placeholders.uniq.one? }
      .each do |placeholders|
        num_fixed_digits = placeholders.select { |v| v == "%i" }.length
        mask_template = placeholders.join
        fixed_digits = (0..9).to_a.repeated_permutation(num_fixed_digits).lazy
        fixed_digits = fixed_digits.reject { |digits| digits.first == 0 } if placeholders.first == :o
        fixed_digits.each do |digits|
          mask = (mask_template % digits)
print "\rtemplate: #{ mask_template}, digits: #{ digits.inspect }, mask: #{ mask }"
          next if mask[-1] == "2"
          family = (0..9).map { |varying| x = mask.gsub(/x/, varying.to_s) }.tap do |_family|
            _family.reject! { |x| x[0] == "0" }
            _family.map! &:to_i
            _family.select! { |value| [1, 5].include?(value % 6) }
          end
          next if family.length < LEN
          family.select! &:prime?
          yielder << family if family.length >= LEN
        end
    end
    num_digits += 1
  end
end

puts results.next
