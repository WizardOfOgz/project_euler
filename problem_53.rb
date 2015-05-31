class Integer
  FACTORIAL_CACHE = {}
  def factorial
    FACTORIAL_CACHE[self] ||= begin
      (1..self).inject 1, :*
    end
  end
end

def n_take_r(n, r)
  n.factorial / (r.factorial * (n - r).factorial)
end

count = (1..100).map do |n|
  max_idx = n / 2
  idx = (1..max_idx).to_a.bsearch { |x| 1_000_000 < n_take_r(n, x) }
  idx ? ((n + 1) - (idx * 2)) : 0
end.inject(:+)

puts count
