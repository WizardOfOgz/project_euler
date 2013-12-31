=begin
An irrational decimal fraction is created by concatenating the positive integers:

0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If d(n) represents the nth digit of the fractional part, find the value of the following expression.

d(1) × d(10) × d(100) × d(1000) × d(10000) × d(100000) × d(1000000)
=end

# First 9 take one digit          9 * 1 = 9
# Next 90 take two digits        90 * 2 = 180
# Next 900 take three digits    900 * 3 = 2_700
# Next 9000 take four digits   9000 * 4 = 36_000

IntegerPlaces = Enumerator.new do |yielder|
  x = 0
  total = 0
  loop do
    total += (x + 1) * 9 * 10 ** x
    yielder << total
    # yielder << (x + 1) * 9 * 10 ** x
    x += 1
  end
end

def champernowne_digit_at(i)
  places = IntegerPlaces.take_while{|x| x <= (i - 1) }
  remaining_places = i - 1 - (places.last || 0)
  places_per_number = places.length + 1
  integer_offset, place_offset = remaining_places.divmod(places_per_number)
  current_integer = (10 ** places.length) + integer_offset

# puts "#{current_integer.to_s[place_offset].to_i} -- i: #{i}, p: #{places}, rp: #{remaining_places}, ppn: #{places_per_number}, io: #{integer_offset}, po: #{place_offset}, ci: #{current_integer}"

  current_integer.to_s[place_offset].to_i
end

t0 = Time.now
(0..6).map{|x| champernowne_digit_at(10 ** x) }.inject(&:*)
t1 = Time.now

puts "#{(0..6).map{|x| champernowne_digit_at(10 ** x) }.inject(&:*)} (#{t1 - t0})"
