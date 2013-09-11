Array.class_eval do
  def sum
    self.inject(0){|sum, element| sum + element }
  end
end

def proper_divisors(x)
  (1..(x/2)).select do |divisor|
    x % divisor == 0
  end
end

# abundant numbers < 28123
abundant_numbers = (1...28123).select do |x|
  # Proper divisors of x
  proper_divisors(x).sum > x
end

# Sums...cartesian and sort????
abundant_sums = abundant_numbers.product(abundant_numbers).map(&:sum)
abundant_sums.select!{|x| x < 28123 }
abundant_sums.uniq!

non_abundant_sums = (1...28123).to_a - abundant_sums
non_abundant_sums.sum

#=> 4179871

# ----------------------------------------------------------------------------
def proper_divisors2(x)
  [].tap do |divisors|
    (1..(Math.sqrt(x).ceil)).each do |divisor|
      quotient, remainder = divisor.divmod(x)
      divisors |= [x, quotient] if remainder == 0
    end
  end
end

# abundant numbers < 28123
abundant_numbers = (1...28123).select do |x|
  # Proper divisors of x
  proper_divisors(x).sum > x
end

# Sums...cartesian and sort????
abundant_sums = abundant_numbers.product(abundant_numbers).map(&:sum)
abundant_sums.select!{|x| x < 28123 }
abundant_sums.uniq!

non_abundant_sums = (1...28123).to_a - abundant_sums
non_abundant_sums.sum