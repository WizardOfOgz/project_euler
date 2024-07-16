require 'sorted_set'

# Added for Problem #3
# Prime generator using sieve of Eratosthenes
# Slow, use Ruby stdlib prime instead.
class Primal
  attr_accessor :current, :sieve_start, :sieve_size

  def initialize
    self.current = nil
    self.sieve_start = 2
    self.sieve_size = 1_000
  end

  def primes
    @primes ||= []
  end

  def sieve
    @sieve ||= gen_sieve
  end

  def sieve_end
    sieve_start + sieve_size
  end

  def gen_sieve(min = sieve_start)
    # pp "gen_sieve #{min}...#{min + sieve_size}"
    (min...min + sieve_size).to_a.tap do |s|
      primes.each do |p|
        filter_sieve(p, s)
      end
    end
  end

  def filter_sieve(n, s = sieve)
    # pp "Filter #{n}"
    c = ((current || sieve_start) / n) * n
    while c <= sieve_end do
      # puts "> #{c}"
      s.delete(c)
      c += n
    end
  end

  def current_sieve_max
    @current + @sieve_size
  end

  def next
    next_prime = sieve.shift
    # pp "Next: #{next_prime}"

    if !next_prime
      self.sieve_start = sieve_end
      @sieve = gen_sieve
      self.next
    else
      primes << next_prime
      filter_sieve(next_prime)
      self.current = next_prime
    end
  end
end


# load 'utils/prime.rb'

# p = Primal.new

# e = Enumerator.new do |yielder|
#   loop do
#     yielder << p.next
#   end
# end

# puts e.lazy.drop(25_000).first

require 'prime'
module PrimeExt
  def relatively_prime?(n)
    n_prime_factors = Set.new(n.prime_division.map(&:first))
    !self.prime_division.map(&:first).any? { |p| n_prime_factors.include?(p) }
  end
end
Integer.prepend PrimeExt
