module Utils
  def self.gcd(u, v)
    # puts [u,v].inspect
    if u == 0
      v
    elsif v == 0
      u
    elsif u & 1 == 0
      if v & 1 == 0
        2 * gcd(u/2, v/2)
      else
        gcd(u/2, v)
      end
    elsif v & 1 == 0
      gcd(u, v/2)
    else
      gcd((u - v).abs, [u, v].min)
    end
  end
end

module GCDExt
  def gcd(n)
    Utils.gcd(self, n)
  end
end

Integer.prepend GCDExt
