=begin
The number 3797 has an interesting property. Being prime itself, it is possible to continuously remove digits from left to right, and remain prime at each stage: 3797, 797, 97, and 7. Similarly we can work from right to left: 3797, 379, 37, and 3.

Find the sum of the only eleven primes that are both truncatable from left to right and right to left.

NOTE: 2, 3, 5, and 7 are not considered to be truncatable primes.
=end

require 'prime'

# Returns all primes created by appending a digit (1, 3, 7, or 9. All other digits would guarantee non-prime) to the given integer.
# Example:
#   prime_productions(7)  #=> [71, 73, 79]
def prime_productions(n)
  digits = n.to_s
  %w[1 3 7 9].map{|suffix| (digits + suffix).to_i }.select(&:prime?)
end

# Returns true if n and all left- and right-anchored truncations are prime
def is_truncatable_prime?(n)
  digits = n.to_s
  n.prime? && (0...(digits.length - 1)).all?{|i| digits[0..i].to_i.prime? && digits[(i + 1)..-1].to_i.prime? }
end

# Recursively build a list of bi-directionally-truncatable primes
def truncatable_primes(primes = [2,3,5,7])
  primes.select{|x| is_truncatable_prime?(x)} + primes.map{|x| truncatable_primes(prime_productions(x))}.flatten
end

puts truncatable_primes.select{|x| x > 9 }.inject(&:+)

t0 = Time.now
results = truncatable_primes
t1 = Time.now

puts "--------->\n#{results.inspect}"

puts "SUM: #{results.select{|x| x > 9 }.inject(&:+)} (#{t1 - t0}s)"


# --------------------------------- Revision ------------------------------

def is_truncatable_prime?(n)
  n.prime? && rtl_truncatable_prime?(n) && ltr_truncatable_prime?(n)
end

def rtl_truncatable_prime?(n)
  n.prime? && (n < 10 || rtl_truncatable_prime?(n/10))
end

def ltr_truncatable_prime?(n, iter = 0)
  rhs = (n % 10 ** iter)
  (rhs == 0 || rhs.prime?) && (rhs == n ? true : ltr_truncatable_prime?(n, iter + 1))
end

t0 = Time.now
results = truncatable_primes
t1 = Time.now

puts "--------->\n#{results.inspect}"

puts "SUM: #{results.select{|x| x > 9 }.inject(&:+)} (#{t1 - t0}s)"
# --------------------------------- Revision ------------------------------

def is_truncatable_prime?(n)
  n.prime? && begin
    digit_place = 0
    m = 0
    is_truncatable_prime = true
    while n > 10
      n, remainder = n.divmod(10)
      m += remainder * (10 ** digit_place)
      is_truncatable_prime &= (n.prime? && m.prime?)
      break unless is_truncatable_prime
      digit_place += 1
    end
    is_truncatable_prime && n.prime?
  end
end

t0 = Time.now
results = truncatable_primes
t1 = Time.now

puts "--------->\n#{results.inspect}"

puts "SUM: #{results.select{|x| x > 9 }.inject(&:+)} (#{t1 - t0}s)"


# --------------------------------- Revision ------------------------------
module Euler37
  # Returns all primes created by appending a digit (1, 3, 7, or 9. All other digits would guarantee non-prime) to the given integer.
  # Example:
  #   prime_productions(7)  #=> [71, 73, 79]
  def prime_productions
    %w[1 3 7 9].map{|suffix| (to_s + suffix).to_i }.select(&:prime?)
  end

  # Returns true if self and all left- and right-anchored truncations are prime
  def is_truncatable_prime?
    prime? && (0...(to_s.length - 1)).all?{|i| to_s[0..i].to_i.prime? && to_s[(i + 1)..-1].to_i.prime? }
  end
end
Integer.send(:include, Euler37)

# Recursively build a list of bi-directionally-truncatable primes
def truncatable_primes(primes = [2,3,5,7])
  primes.select(&:is_truncatable_prime?) + primes.map{|x| truncatable_primes(x.prime_productions)}.flatten
end

puts truncatable_primes.select{|x| x > 9 }.inject(&:+)  # Sum all truncatable primes which have more than one digit

t0 = Time.now
truncatable_primes
t1 = Time.now

results = truncatable_primes
puts "--------->\n#{results.inspect}"

puts "R4 SUM: #{results.select{|x| x > 9 }.inject(&:+)} (#{t1 - t0}s)"
