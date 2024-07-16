class Node
  attr_accessor :distance
end



def pe13
  max_start = 0
  max_length = 0

  (1...1000000).each do |n|
    # p n
    len = trail(n).length
    if len > max_length
      max_length = len
      max_start = n
    end
  end

  [max_start, max_length]
end

def pe13_smarter
  max_start = 0
  max_length = 0

  (1...1000000).each do |n|
    # p n
    len = trail_len(n)
    if len > max_length
      max_length = len
      max_start = n
    end
  end

  [max_start, max_length]
end

def trail_len(n)
  @trail ||= {1 => 1}

  trail = []
  # trail.push(n) unless @trail[n]
  last_m = n
  last_distance = 0

  while n != 1
    k = n

    if @trail[n]
      last_distance = @trail[n]
      break
    elsif n % 2 == 0
      n = n/2
    else
      n = 3*n + 1
    end

    trail.push k
    trail.push(1) if n==1
  end

  while m = trail.pop
    last_distance += 1
    # p "#{m}: #{last_distance}"
    @trail[m] = last_distance
    last_m = m
  end

  @trail[last_m]
end

def trail(n)
  trail = [n]

  while n != 1

    if n % 2 == 0
      n = n/2
    else
      n = 3*n + 1
    end

    trail.push n
  end

  trail
end

pp pe13_smarter
