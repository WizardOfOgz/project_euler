require 'prime'

results = Enumerator.new do |yielder|
  primes = {}

  (1000..9999).to_a.lazy
    .select(&:prime?)
    .each do |value|
      key = value.to_s.split("").sort.join
      primes[key] ||= []
      primes[key] << value
    end

  primes.lazy
    .select { |key, values| values.length > 2 }
    .each do |key, values|
      values.sort.combination(3).lazy
        .each do |vals|
# puts "--> #{ vals.inspect }: #{ vals.each_cons(2).map { |x, y| y - x }.inspect }"
          yielder << vals if vals.each_cons(2).map { |x, y| y - x }.uniq.length == 1
        end
    end
end

results.each do |x|
  # puts "-------------\n#{ x }"
puts "--> #{ x.inspect } ( #{ ("%04i" * 3) % x } ): #{ x.each_cons(2).map { |x, y| y - x }.inspect }"

end
