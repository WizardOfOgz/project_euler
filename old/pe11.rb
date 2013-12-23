a = [
  [1, 2, 3, 4],
  [2, 3, 4, 5],
  [3, 4, 5, 6],
  [4, 5, 6, 7],
]

a = [
  [1, 20, 3, 4, 5],
  [2, 3, 40, 5, 6],
  [3, 4, 5, 6, 7],
  [4, 5, 6, 7, 8],
]

rows = a.length
cols = a.first.length

a_hor = Array.new(rows) { Array.new(cols-1) }
a_ver = Array.new(rows-1) { Array.new(cols) }
a_dor = Array.new(rows-1) { Array.new(cols-1) }
a_uor = Array.new(rows-1) { Array.new(cols-1) }

(a_hor.length).times do |i|
  (a_hor.first.length).times do |j|
    a_hor[i][j] = a[i][j] * a[i][j+1]
  end
end

(a_ver.length).times do |i|
  (a_ver.first.length).times do |j|
    a_ver[i][j] = a[i][j] * a[i+1][j]
  end
end

(a_dor.length).times do |i|
  (a_dor.first.length).times do |j|
    a_dor[i][j] = a[i][j] * a[i+1][j+1]
  end
end

(a_uor.length).times do |i|
  (a_uor.first.length).times do |j|
    a_uor[a_uor.length-i-1][j] = a[a.length-i-1][j] * a[a.length-i-2][j+1]
  end
end

p a
p a_hor
p a_ver
p a_dor
p a_uor


a_hor_4 = Array.new(a_hor.length) { Array.new(a_hor.first.length-2)}
a_ver_4 = Array.new(a_ver.length-2) { Array.new(a_ver.first.length)}
a_dor_4 = Array.new(a_dor.length-2) { Array.new(a_dor.first.length-2)}
a_uor_4 = Array.new(a_uor.length-2) { Array.new(a_uor.first.length-2)}

(a_hor_4.length).times do |i|
  (a_hor_4.first.length).times do |j|
    a_hor_4[i][j] = a_hor[i][j] * a_hor[i][j+2]
  end
end

(a_ver_4.length).times do |i|
  (a_ver_4.first.length).times do |j|
    a_ver_4[i][j] = a_ver[i][j] * a_ver[i+2][j]
  end
end

(a_dor_4.length).times do |i|
  (a_dor_4.first.length).times do |j|
    a_dor_4[i][j] = a_dor[i][j] * a_dor[i+2][j+2]
  end
end

(a_uor_4.length).times do |i|
  (a_uor_4.first.length).times do |j|
    a_uor_4[a_uor_4.length-i-1][j] = a_uor[a_uor.length-i-1][j] * a_uor[a_uor.length-i-3][j+2]
  end
end

p a_hor_4
p a_ver_4
p a_dor_4
p a_uor_4

[a_hor_4 + a_ver_4 + a_dor_4 + a_uor_4].flatten.max