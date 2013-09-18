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
  return [] if x < 2
  divisors = [1]
  (2..(Math.sqrt(x).ceil)).each do |divisor|
    quotient, remainder = x.divmod(divisor)
    divisors |= [divisor, quotient] if remainder == 0
  end
  divisors
end

# abundant numbers < 20161
abundant_numbers2 = (1...20161).select do |x|
  # Proper divisors of x
  proper_divisors2(x).sum > x
end

# Sums...cartesian and sort????
abundant_sums2 = abundant_numbers2.product(abundant_numbers2).map(&:sum)
abundant_sums2.select!{|x| x < 20161 }
abundant_sums2.uniq!

non_abundant_sums2 = (1...20161).to_a - abundant_sums2
non_abundant_sums2.sum


# ----------------------------------------------------------------------------
Array.class_eval do
  def sum
    self.inject(0){|sum, element| sum + element }
  end
end

def proper_divisors2(x)
  return [] if x < 2
  return [1] if x == 2
  divisors = [1]
  (2..(Math.sqrt(x).ceil)).each do |divisor|
    quotient, remainder = x.divmod(divisor)
    divisors |= [divisor, quotient] if remainder == 0
  end
  divisors
end


sums = []
abs = []

(1..20161).each do |x|
  if proper_divisors2(x).sum > x
    abs << x
    sums |= abs.map{|ab| ab + x}.reject{|s| s > 20161}
  end
end

((1..20161).to_a - sums).sum

