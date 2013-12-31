# encoding utf-8

=begin
In England the currency is made up of pound, £, and pence, p, and there are eight coins in general circulation:

1p, 2p, 5p, 10p, 20p, 50p, £1 (100p) and £2 (200p).
It is possible to make £2 in the following way:

1×£1 + 1×50p + 2×20p + 1×5p + 1×2p + 3×1p
How many different ways can £2 be made using any number of coins?
=end


two_pound = 200
one_pound = 100
fifty_pence = 50
twenty_pence = 20
ten_pence = 10
five_pence = 5
two_pence = 2
one_pence = 1

combinations = 0

(0..200/two_pound).each do |two_pound_count|
  remaining_two_pound = 200 - two_pound * two_pound_count
  combinations += 1 if remaining_two_pound == 0
  next if remaining_two_pound <= 0

  (0..200/one_pound).each do |one_pound_count|
    remaining_one_pound = remaining_two_pound - one_pound * one_pound_count
    combinations += 1 if remaining_one_pound == 0
    next if remaining_one_pound <= 0

    (0..200/fifty_pence).each do |fifty_pence_count|
      remaining_fifty_pence = remaining_one_pound - fifty_pence * fifty_pence_count
      combinations += 1 if remaining_fifty_pence == 0
      next if remaining_fifty_pence <= 0

      (0..200/twenty_pence).each do |twenty_pence_count|
        remaining_twenty_pence = remaining_fifty_pence - twenty_pence * twenty_pence_count
        combinations += 1 if remaining_twenty_pence == 0
        next if remaining_twenty_pence <= 0

        (0..200/ten_pence).each do |ten_pence_count|
          remaining_ten_pence = remaining_twenty_pence - ten_pence * ten_pence_count
          combinations += 1 if remaining_ten_pence == 0
          next if remaining_ten_pence <= 0

          (0..200/five_pence).each do |five_pence_count|
            remaining_five_pence = remaining_ten_pence - five_pence * five_pence_count
            combinations += 1 if remaining_five_pence == 0
            next if remaining_five_pence <= 0

            (0..200/two_pence).each do |two_pence_count|
              remaining_two_pence = remaining_five_pence - two_pence * two_pence_count
              combinations += 1 if remaining_two_pence >= 0
            end
          end
        end
      end
    end
  end
end

puts "Combinations: #{combinations}"
