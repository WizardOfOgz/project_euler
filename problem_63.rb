results = []
n = 1
while (9 ** n).to_s.length >= n
  (1..9).each do |x|
    m = x ** n
    results << m if m.to_s.length == n
  end
  n += 1
end

puts results.length
