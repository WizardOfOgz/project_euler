def sequence(x)
  digits = {}
  quotient_remainder = [0, 1]
  last = quotient_remainder
  sequence = []

  loop do
    quotient_remainder = (quotient_remainder.last * 10).divmod(x)
# puts "(#{x}): #{quotient_remainder.inspect} : digits #{digits.inspect}"


    digits[last] = quotient_remainder
    if digits[quotient_remainder]
      # Found a cycle
      key = quotient_remainder.dup

      begin
        sequence << key.first
        key = digits[key]
      end while key != quotient_remainder
      break
    else
      last = quotient_remainder
    end

  end
  sequence == [0] ? [] : sequence
end

best_x = nil
best_sequence = [0]
t0 = Time.now
(1..1000).map do |x|
  # [x, sequence(x)]
  seq = sequence(x)
  if seq.length > best_sequence.length
    best_x = x
    best_sequence = seq
  end
end
t1 = Time.now

puts "\n\n------------------------------------------ (#{t1-t0}s)"
puts best_x
puts best_sequence.inspect
