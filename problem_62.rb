

def results(target_permutations: 5)
  length = 1
  cube_generator = Enumerator.new do |yielder|
    x = 1
    loop do
      yielder << x ** 3
      x += 1
    end
  end.lazy

  loop do
    # get all cubes of length
    cubes = cube_generator.drop_while { |n| n.to_s.length < length }.take_while { |n| n.to_s.length == length }
# puts "----------------------\nLength: #{length}\n#{cubes.to_a.inspect}"

    # index permutations
    cubes_index = {}
    cubes.each do |c|
      (cubes_index[c.to_s.split("").sort.join] ||= []) << c
    end

    # count and find the smallest matching cube
    result = cubes_index.select { |k,cs| cs.length == target_permutations }.map { |k,cs| cs.min }.min
# puts cubes_index.select { |k,cs| cs.length == target_permutations }.inspect if result
    return result if result

    length += 1
  end
end


puts results(target_permutations: 5)

# cubes_index = {}
# x = 1
# loop
#   x += 1
#   n = x ** 3
#   digits = n.to_s.split("")
#   key = digits.sort.join
#
#   digits.permutation.lazy.map(&:join).map(&:to_i).each do |m|
#     cubes_index[key]
#   end
# end
#
# puts x
