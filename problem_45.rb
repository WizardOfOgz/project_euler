triangle_numbers = Enumerator.new do |yielder|
  n = 1
  loop do
    yielder << n * (n + 1) / 2
    n += 1
  end
end

pentagonal_numbers = Enumerator.new do |yielder|
  n = 1
  loop do
    yielder << n * (3 * n - 1) / 2
    n += 1
  end
end

hexagonal_numbers = Enumerator.new do |yielder|
  n = 1
  loop do
    yielder << n * (2 * n - 1)
    n += 1
  end
end


results = Enumerator.new do |yielder|
  t = 0
  p = 0
  h = 0

  loop do
    t = triangle_numbers.next
    p = pentagonal_numbers.next while p < t
    h = hexagonal_numbers.next while h < t

    yielder << t if t == p && t == h
  end
end

puts results.next
puts results.next
puts results.next
