require 'prime'
def factors(x)
  [].tap do |_factors|
    prime_generator = Prime.each
    y = x
    p = 0
    while p <= y
      p = prime_generator.next
      if y % p == 0
        _factors << p
return [] if _factors.length > 4
        y /= p while y % p == 0
      end
    end
    _factors.uniq!
  end
end

results = Enumerator.new do |yielder|
  x = 1
  consecutive = []
  loop do
    if count_distinct_prime_factors(x) == 4
      j = x - 1
      while count_distinct_prime_factors(j) == 4
        consecutive << j
        yielder << consecutive.unshift(x) if consecutive.length == 3
        j -= 1
      end

      k = x + 1
      while count_distinct_prime_factors(k) == 4
        consecutive << k
        yielder << consecutive.unshift(x) if consecutive.length == 3
        k += 1
      end

      x = k
    end

    if consecutive.any?
puts "------\n#{ consecutive }" if consecutive.length > 2
      consecutive = []
    end

    x += 4
  end
end

# puts factors(644).inspect
# puts factors(645).inspect
# puts factors(646).inspect

# puts results.next
t0 = Time.now; x = results.next; puts Time.now - t0; puts x






















require 'prime'
def count_distinct_prime_factors(n)
  count = 0
    prime_generator = Prime.instance.each

  i = prime_generator.next
  while i <= Math.sqrt(n)
    if n % i == 0
      count += 1
      n /= i while n % i == 0
    end
    # i += i == 2 ? 1 : 2
    i = prime_generator.next
  end

  n > 1 ? count + 1 : count
end

def is_consecutive_number(n, number_of_digits)
  i = n
  while i < n + number_of_digits
    if count_distinct_prime_factors(i) != number_of_digits
      return false
    end
    i += 1
  end
  true
end

def find_first_consecutive_number(number_of_digits)
  n = 1
  loop do
    if is_consecutive_number(n, number_of_digits)
      return n
    end
    n += 1
  end
end

find_first_consecutive_number(4)
