pentagonal_numbers = Enumerator.new do |yielder|
  x = 1
  loop do
    yielder << x * (3 * x - 1) / 2
    x += 1
  end
end




def isqrt(n)
  x = n + 1  # Initialized value just needs to be bigger than xk
  xk = n

  while (x > xk)
    x = xk
    xk = (x + (n / x)) / 2
  end

  x
end

def is_pentagonal?(n)
  pn = 24 * n + 1
  iroot = isqrt(pn)

  (iroot ** 2 == pn) && iroot % 6 == 5
end

def pentagonal(n)
  @pentagonal ||= {}
  @pentagonal[n] ||= n * (3 * n - 1) / 2
end

(1..5000).each do |j|
  (1...j).each do |k|
    # pk, pj = pentagonal(k), pentagonal(j)
    # puts [k, j].inspect
    if is_pentagonal?(pentagonal(j) - pentagonal(k))
      # puts "P(#{k}) = #{pk}, P(#{j}) = #{pj}, #{pj-pk}"
      puts "#{k}, #{j}"
      if is_pentagonal?(pentagonal(k) + pentagonal(j))
        puts "Winner: #{k} #{j}"
      end
    end
  end
end


puts pentagonal(4).inspect
puts pentagonal(7).inspect
puts (pentagonal(4) + pentagonal(7)).inspect
puts is_pentagonal?(pentagonal(4) + pentagonal(7)).inspect

puts pentagonal(7).inspect
puts pentagonal(8).inspect
puts (pentagonal(8) - pentagonal(7)).inspect
puts is_pentagonal?(pentagonal(8) - pentagonal(7)).inspect
