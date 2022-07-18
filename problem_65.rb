# Convergents of e

def reduce_continued_fractions(*args)
  args.reverse.reduce([1, 0]) do |(num, den), arg|
    # puts [arg].inspect
    r = [arg * num + den, num]
    puts [arg, num, den, r].inspect
    r
  end
end

puts reduce_continued_fractions(2, 2, 2, 2, 2).inspect

e_continued_series = Enumerator.new do |yielder|
  (2..).step(2).each do |n|
    yielder << 1
    yielder << n
    yielder << 1
  end
end

# e_convergents = reduce_continued_fractions(*[2]*9)
e_convergent_den, e_convergent_num = reduce_continued_fractions(*e_continued_series.take(99))

# result = [2 * e_convergent_den + e_convergent_num, e_convergent_den]
result = 2 * e_convergent_den + e_convergent_num

puts result

puts result.digits.sum
