require 'set'
require 'sorted_set'

generators = {}

# Triangle	 	P3,n=n(n+1)/2	 	1, 3, 6, 10, 15, ...
generators[3] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * (n + 1) / 2
  end
end.lazy

# Square	 	P4,n=n2	 	1, 4, 9, 16, 25, ...
generators[4] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * n
  end
end.lazy

# Pentagonal	 	P5,n=n(3n−1)/2	 	1, 5, 12, 22, 35, ...
generators[5] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * (3 * n - 1) / 2
  end
end.lazy

# Hexagonal	 	P6,n=n(2n−1)	 	1, 6, 15, 28, 45, ...
generators[6] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * (2 * n - 1)
  end
end.lazy

# Heptagonal	 	P7,n=n(5n−3)/2	 	1, 7, 18, 34, 55, ...
generators[7] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * (5 * n - 3) / 2
  end
end.lazy

# Octagonal	 	P8,n=n(3n−2)	 	1, 8, 21, 40, 65, ...
generators[8] = Enumerator.new do |yielder|
  n = 0
  loop do
    n += 1
    yielder << n * (3 * n - 2)
  end
end.lazy

candidates = {}
generators.each do |key, enumerator|
  candidates[key] = enumerator.
    drop_while { |n| n < 1000 }.
    take_while { |n| n < 10_000 }.
    inject({ front: {}, back: {}}) do |h,n|
      /(?<f>\d{2})(?<b>\d{2})/ =~ n.to_s
      f = f.to_i
      b = b.to_i
      (h[:front][f] ||= SortedSet.new) << b unless b < 10
      # (h[:back][b] ||= SortedSet.new) << f
      h
    end
end
# puts candidates.inspect
# Build graph
# Detect cycle

# candidates.each do |level, h|
#   path = []
#   h[:front].each do |f|
#     path << f
#     f.each do |b|
#       path << b
#
#       path.pop b
#     end
#     path.pop  # Remove f
#   end
# end


results = Enumerator.new do |yielder|
  walk = -> candidates, path = [], level = nil, front = nil {
# puts path.inspect
    remaining_levels = candidates.keys - path.map {|meta| meta[:level] } - [level]

    fronts = candidates[level][:front]
    fronts = fronts.select { |f,fs| f == front } if front

    fronts.each do |f, bs|
      bs.each do |b|
        if remaining_levels.any?
          candidates.lazy.select { |l,h| remaining_levels.include?(l) }.each do |l,h|
            # (h[:front][b] || []).each do |_f|
# puts [b, _f].inspect
              walk[candidates, path + [{:level => level, :front => f, :back => b, :number => "#{f}#{b}"}], l, b]
            # end
          end
        else
# puts (path + [{:level => level, :front => f, :back => b}]).inspect
          yielder << path + [{:level => level, :front => f, :back => b, :number => "#{f}#{b}"}] if b == path.first[:front]
        end
      end
    end
  }
  walk[candidates, [], 5]
end

r = results.next
puts r.inspect
puts r.map{|_r| _r[:number] }.inspect
puts r.map{|_r| _r[:number] }.map(&:to_i).inject(:+).inspect

# puts (3..8).to_a.map {|s| candidates[s].length }.inspect
# puts (3..8).to_a.map {|s| candidates[s].length }.inject(:*)
# (3..8).to_a.combination(2).each do |a,b|
#   puts "#{ a },#{ b }: #{ (candidates[a] & candidates[b]).inspect }"
# end
