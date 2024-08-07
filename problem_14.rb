# Longest Collatz sequence
# https://projecteuler.net/problem=14

# The following iterative sequence is defined for the set of positive integers:

# n → n/2 (n is even)
# n → 3n + 1 (n is odd)

# Using the rule above and starting with 13, we generate the following sequence:
# 13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1

# It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

# Which starting number, under one million, produces the longest chain?

# NOTE: Once the chain starts the terms are allowed to go above one million.

class Collatz
  def cache
    @cache ||= { 1 => 1 }
  end

  def chain_len(n)
    if cache[n]
      cache[n]
    else
      cache[n] = 1 + chain_len(succ(n))
    end
  end

  def succ(n)
    if n.even?
      n / 2
    else
      3 * n + 1
    end
  end
end

collatz = Collatz.new

puts (1...1_000_000).lazy.max_by { |n| collatz.chain_len(n) }


### Follow-up, optimizations

class Collatz2
  def cache
    @cache ||= { 1 => 1 }
  end

  def chain_len(n)
    if cache[n]
      cache[n]

    elsif n.even?
      cache[n] = 1 + chain_len(n / 2)
    else
      cache[n] = 2 + chain_len((3 * n + 1) / 2)
    end
  end
end

collatz = Collatz2.new

puts (500_000...1_000_000).lazy.max_by { |n| collatz.chain_len(n) }
