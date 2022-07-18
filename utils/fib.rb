module Kernel
  # Added for Problem #2
  FIBONACCI_SEQ = Enumerator.new do |yielder|
    i = 0
    j = 1
    yielder << i
    yielder << j
    loop do
      k = i + j
      yielder << k
      i = j
      j = k
    end
  end.lazy

  def fib(n)
    FIBONACCI_SEQ.drop(n).first
  end
end
