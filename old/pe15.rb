# 1 1 1 1
# 1 2 3 4
# 1 3 6 10
# 1 4 1020


def pascal_triangle_grid(n)
  grid = Array.new(n) { Array.new(n) }

  n.times do |i|
    grid[i][0] = 1
    grid[0][i] = 1
  end

  (1...n).each do |j|
    (1...n).each do |i|
      # puts "#{i}, #{j}"
      grid[i][j] = grid[i-1][j] + grid[i][j-1]
    end
  end

  grid
end


