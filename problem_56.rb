max = 0
(1..100).to_a.reverse.each do |a|
  local_max = 0
  (0..100).to_a.reverse.each do |b|
    n = a ** b
    digits = n.to_s.split("")

    break if 9 * digits.length < local_max

    sum = digits.map(&:to_i).inject(:+)
    if sum > local_max
      local_max = sum
      max = sum if sum > max
    end
  end
end

puts max
