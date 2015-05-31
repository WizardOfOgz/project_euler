pentagonal_numbers = Enumerator.new do |yielder|
  x = 1
  loop do
    yielder << x * (3 * x - 1) / 2
    x += 1
  end
end


ps = pentagonal_numbers.take(10)

e = pentagonal_numbers.lazy.each_cons(2).map {|a,b| [a, b, b - a] }

while (a, b, d = e.next; a + b > d)
  puts [a,b,d].inspect
end


(n-1)(3(n-1)-1)/2 = (n+1)(3(n+1)-1)/2 - n(3n-1)/2
(n-1)(3n-4)/2 = (n+1)(3n+2)/2 - n(3n-1)/2
(3n^2 - 7n + 4) = (3n^2 + 5n + 2) - (3n^2 - n)
3n^2 - 7n + 4 = 6n + 2
3n^2 - 13n + 2 = 0



n(3n-1)/2 + (n+1)(3(n+1)-1)/2 = (n+2)(3(n+2)-1)/2
3n^2 - n + (n+1)(3n+2) = (n+2)(3n+5)
3n^2 - n + (3n^2 + 5n + 2) = 3n^2 + 11n + 10
6n^2 + 4n + 2 = 3n^2 + 11n + 10
3n^2 - 7n - 8 = 0


3n^2 - 7n - 8 = 3n^2 - 13n + 2
- 7n - 8 = - 13n + 2
6n - 10 = 0
6n = 10
n = 10/6
