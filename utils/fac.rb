Integer.prepend Module.new {
  def fac
    if self > 0
      (1..self).reduce(&:*)
    elsif self == 0
      1
    else
      raise ArgumentError, "Factorial of #{self} does not exist"
    end
  end
}
