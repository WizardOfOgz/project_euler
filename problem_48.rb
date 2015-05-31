series = Enumerator.new do |yielder|
  x = 1
  sum = 0
  loop do
    sum += x ** x
    sum %= 10000000000
    yielder << sum
    x += 1
  end
end

series.lazy.take(1000).each_with_index do |x, idx|
  puts [idx + 1, x.to_s[-10..-1]] if idx % 10 == 9
end
