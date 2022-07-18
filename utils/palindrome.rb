String.prepend Module.new {
  # Added for Problem #4
  def is_palindrome?
    head_pos = ((length - 1) / 2).floor
    tail_pos = ((length) / 2).floor

    while head_pos >= 0
      return false unless self[head_pos] == self[tail_pos]
      head_pos -= 1
      tail_pos += 1
    end

    return true
  end
}
