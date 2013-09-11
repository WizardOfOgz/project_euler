names = eval("[#{File.read('resources/names.txt')}]")
names.sort!
names.map{|x| x.each_byte.map{|y| y - 64}.inject(&:+) }.each_with_index.map{|x,i| x * (i+1) }.inject(&:+)

#=> 871198282