require 'prime'

composite_odd_numbers = Enumerator.new do |yielder|
  n = 1
  loop do
    x = 2 * n + 1
    yielder << x unless x.prime?
    n += 1
  end
end

results = Enumerator.new do |yielder|
  loop do
    x = composite_odd_numbers.next
    solution_for_x = (0..Math.sqrt(x / 2).floor).detect do |r|
      (x - 2 * r * r).prime?
    end
    yielder << x unless solution_for_x
  end
end


puts results.next
