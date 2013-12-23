def corners(length)
  return 1 if length==1
  length_squared = length * length
  length_diff = length - 1
  [
    length_squared, 
    length_squared - length_diff,
    length_squared - length_diff * 2,
    length_squared - length_diff * 3
  ]
end

def pe28(length)
  (1..length).to_a.select{|x| x.odd?}.map{|x| corners(x)}.flatten.reduce(&:+)
end