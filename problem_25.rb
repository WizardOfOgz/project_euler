# def fib(n)
#   return 0 if n == 0
#   return 1 if n == 1
#   fib(n-1) + fib(n-2)
# end

prev = 0
fib = 1
n = 1

while(fib.to_s.length < 1000)
  prev, fib = [fib, fib + prev]
  n += 1
end

puts fib
puts n