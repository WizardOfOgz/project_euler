def pentagonal_number(x)
  x * (3 * x - 1) / 2
end

pentagonal_numbers = Enumerator.new do |yielder|
  x = 1
  loop do
    yielder << pentagonal_number(x)
    x += 1
  end
end


results = Enumerator.new do |yielder|
  diffs = {}
  ps = []

  loop do
    p = pentagonal_numbers.next
    ps
      .map {|psp| [p - psp, psp] }
      .select { |diff, _| ps.bsearch { |psp| diff <=> psp } }
      .each do |diff, psp|
        if ps.bsearch { |_p| diff <=> _p }
          diffs[[psp, p]] = diff

          if d = diffs[[diff, psp]]
            # puts "Winner! #{ [d, diff, psp, p] }"
            yielder << psp - diff
          end
        end
      end
    ps << p
  end
end

puts results.next

# puts ps
# puts "--------------"
# puts diffs

# puts ps.each_cons(2) {|x,y| y - x }
