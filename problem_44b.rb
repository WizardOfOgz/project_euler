pentagonal_numbers = Enumerator.new do |yielder|
  x = 1
  loop do
    yielder << x * (3 * x - 1) / 2
    x += 1
  end
end


ps = pentagonal_numbers.take(10)

e = pentagonal_numbers.lazy.each_cons(2).map {|a,b| [a, b, b - a] }

while (a, b, d = e.next; a + b > d)
  puts [a,b,d].inspect
end
