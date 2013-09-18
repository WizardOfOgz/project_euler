class Integer
  def fact
    (2..self).reduce(:*) || 1
  end
end


def nth_permutation(n, number_of_digits)
  return if n > number_of_digits.fact
  current_number = n - 1
  current = number_of_digits - 1

  places = []
  permutation = []
  available_digits = (0...number_of_digits).to_a

  while current_number > 0
    # select factorial < current_number
    while ((factorial = current.fact) > current_number)
      current -= 1
      permutation << available_digits.shift
    end

    place, current_number = current_number.divmod(factorial)
# puts "#{place * factorial + current_number} #{factorial} #{place} : #{current} #{current_number} : #{permutation.inspect} #{available_digits.inspect}"

    permutation << available_digits.delete_at(place)

    current -= 1
  end

  (permutation + available_digits).join
end

puts nth_permutation(1_000_000, 10)
