def num_divisors(n)
  num_divs(divs(n))
end

def divisors(n)
  divs = [1]
  i = Math.sqrt(n).floor
  while i > 1
    q,r = n.divmod(i)
    if r==0
      divs << i
      divs << q
    end
    i -= 1
  end

  divs.sort.uniq
end

def pe21
  candidates = (0...26000).map{|x| [x,divisors(x).reduce(&:+)]}
  candidates[1...10000].select{|x,y| puts "#{x} == #{candidates[y][1]}"; x != y && x == candidates[y][1] }.map{|x| x[0]}.reduce(&:+)
end