class PrimeTime
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
      break if result
    end
    result
    # @primes.all?{|prime| (prime > root_x) || x % prime != 0 }
  end
end
