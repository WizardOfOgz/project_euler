require 'prime'
require 'set'

results = Enumerator.new do |yielder|
  prime_generator = Prime.each

  candidates = Hash.new { |h, k| h[k] = Set.new }
  primes = Hash.new { |h, k| h[k] = Set.new }

  loop do
    x = prime_generator.next
    s = x.to_s

    (1...s.length).each do |i|
      next if %w[2 4 6 8 0].include?(s[i-1]) || (s.length > 1 && s[i - 1] == "5") || (i == s.length - 1 && s[i] == "5") || (s[i] == "0")
      s1 = s[0...i]
      next unless s1.to_i.prime?
      s2 = s[i..-1]
      next unless s2.to_i.prime?
      r = s2 + s1
      next unless r.to_i.prime?
      primes[x] << s1
      primes[x] << s2
      candidates[s1.to_i] << x
      candidates[s2.to_i] << x
    end

    common = candidates[x].lazy.map{ |components| candidates[components.to_i] }.inject(Set.new) { |common_set, set| common_set &= set }
    if x == 673109
      puts common.inspect
      puts candidates[x].inspect
      puts candidates[x].map{ |components| candidates[components.to_i] }.inspect
      break
    end
  end
end


results.next
