def pe16(n)
  num = 2**n
  sum = 0
  while num > 0
    num, r = num.divmod(10)
    sum += r
  end
  sum
end






