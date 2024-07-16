

def divisors(n)
  divisors = []

  # generate list of numbers to check
  candidates = (1..((n+1)/2)).to_a

  while c = candidates.shift
    quotient, remainder = n.divmod(c)
    if remainder == 0
      divisors << c
      divisors << quotient unless c == quotient

      candidates.delete(quotient)
    end
  end

  divisors
end

def primes(n)
  prime_numbers = [1,2]
  candidates = (1..((n-1)/2)).map{|x| x*2+1 }  # List of odd integers >2 and <= n/2

  while p = candidates.shift
    prime_numbers << p

    multiple_of_p = p
    while (multiple_of_p += p; multiple_of_p <= n)
      candidates.delete(multiple_of_p)
    end
  end

  prime_numbers.sort
end

def pe12(n = 500)
  triangle_number = 1
  triangle_step = 1

  until ((num_divisors = d2(triangle_number).length) > n)
    puts "#{triangle_number}(#{num_divisors})" if (triangle_step%25==0)
    triangle_step += 1
    triangle_number += triangle_step
  end
  triangle_number
end
def pe122(n = 8)
  triangle_number = 1
  triangle_step = 1

  until ((num_divisors = (divs = d2(triangle_number)).length) > n)
    puts "#{triangle_number}: #{divs.sort}"
    # puts "#{triangle_number}(#{num_divisors})" if (triangle_step%25==0)
    triangle_step += 1
    triangle_number += triangle_step
  end
  triangle_number
end

def triangle_numbers(n)
  tri_nums = []
  triangle_number = 0
  triangle_step = 1

  until (triangle_step > n)
    triangle_number += triangle_step
    tri_nums << triangle_number
    triangle_step += 1
  end
  tri_nums
end

def d2(n)
  divisors = []
  m = 1
  while (m <= n/2)
    divisors << m if (n%m == 0)
    m+=1
  end
  divisors
end

def gcd(a,b)
  b,a = [a,b].sort
  until b == 0
    t = b
    b = a % b
    a = t
  end
  a
end

def prime_list
  @prime_list ||= primes(50000)
end

def divs(n)
  i = prime_list.index{|i| i > Math.sqrt(n).floor} - 1

  m = n
  divs = Hash.new(0)
  candidates = []
  until i < 1
    div_candidate = prime_list[i]

    while(mm,r = m.divmod(div_candidate); puts "d=#{div_candidate} m=#{m} r=#{r}"; div_candidate > 1 && r==0)
      m = mm
      divs[div_candidate] += 1
    end

    i -= 1
  end

  divs[m] += 1 unless m == 1

  divs
end

def num_divs(h)
  total_divs = 1
  h.each do |factor,multiplicity|
    total_divs *= (multiplicity + 1)
  end
  total_divs
end


def pe123(n = 8)
  triangle_number = 1
  triangle_step = 1

  until (ds = divs(triangle_number); ns = num_divs(ds); ns > n)
    puts "#{triangle_number}: \##{ns}: #{ds.inspect}"
    # puts "#{triangle_number}(#{num_divisors})" if (triangle_step%25==0)
    triangle_step += 1
    triangle_number += triangle_step
  end
  [triangle_number, ds]
end

# def div_list(n,h)
#   list = []
#   h.each do |factor,multiplicity|
#     f = factor
#     multiplicity.times do
#       list << f
#       f *= factor
#     end
#   end
# end


pp pe12
