results = Enumerator.new do |yielder|
  x = 0
  loop do
    x += 1

    x1 = x.to_s.split("").sort

    x2 = (x * 2).to_s.split("").sort
    next unless x2 == x1

    x3 = (x * 3).to_s.split("").sort
    next unless x3 == x1

    x4 = (x * 4).to_s.split("").sort
    next unless x4 == x1

    x5 = (x * 5).to_s.split("").sort
    next unless x5 == x1

    x6 = (x * 6).to_s.split("").sort
    next unless x6 == x1

    yielder << x
  end
end

puts r = results.next
puts "---------------\n#{ (1..6).map{|x| x * r }.inspect }"
