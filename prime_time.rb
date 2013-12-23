class PrimeTimeOld
  def initialize
    @primes = [2]
    @current = nil
  end

  def next
    if @current
      begin
        @current += 2
      end until new_prime?(@current)
      @primes << @current
      @current
    else
      # First time calling this method
      @current = 1  # At the next iteration this will be incremented to 3
      2
    end
  end

  def prime?(x)
    @primes.include?(x) || new_prime?(x)
  end

  def new_prime?(x)
    root_x = Math.sqrt(x)
    result = true
    @primes.each do |prime|
      break if prime > root_x
      result &= x % prime != 0
      break unless result
    end
    result
  end
end


class PrimeTime
  def initialize
    @primes = [2]
    @current = nil
  end

  def next
    if @current
      if @primes.length < 6
        @current += 2
      else
        low_limit = lower_limit(@primes.length + 1).ceil
        if @current >= low_limit
          @current += 2
        else
          @current = low_limit
          @current += 1 if @current % 2 == 0  # Start with the first odd number greater or equal to the lower limit.
        end
      end

      until new_prime?(@current)
        @current += 2
      end
      @primes << @current
      @current
    else
      # First time calling this method
      @current = 1  # At the next iteration this will be incremented to 3
      2
    end
  end

  def prime?(x)
    @primes.include?(x) || new_prime?(x)
  end

  def new_prime?(x)
    root_x = Math.sqrt(x)
    result = true
    @primes.each do |prime|
      break if prime > root_x
      result &= x % prime != 0
      break unless result
    end
    result
  end

  # Lower limit for nth prime number, where n >= 6
  def lower_limit(n)
    raise ArgumentError, 'n must be >= 6' unless n >= 6
    n * (Math.log(n) + Math.log(Math.log(n)) - 1)
  end

  # Upper limit for nth prime number, where n >= 6
  def upper_limit(n)
    raise ArgumentError, 'n must be >= 6' unless n >= 6
    n * (Math.log(n) + Math.log(Math.log(n)))
  end
end

class PrimeSieve
  def initialize
    @sieve = (1..499999).map{|n| n * 2 + 1 }.unshift(2)
    @current_index = -1
    @primes = []
  end

  def next
    @current_index += 1
    # @sieve.delete_at(@current_index) until next_prime?(@sieve[@current_index]) || @sieve[@current_index].nil?
    @current_index += 1 until @sieve[@current_index].nil? || next_prime?(@sieve[@current_index])
  end

  def current
    @sieve[@current_index]
  end

  def next_prime?(x)
    root_x = Math.sqrt(x)
    result = true
    @sieve[1..-1].each do |prime|
      break if prime > root_x
      result &= x % prime != 0
      break unless result
    end
    result
  end
end
