CARD_RANKS = Hash[%w[2 3 4 5 6 7 8 9 T J Q K A].each_with_index.to_a.map(&:itself)]
# Royal Flush: Ten, Jack, Queen, King, Ace, in same suit.
# Straight Flush: All cards are consecutive values of same suit.
# straight_flush [[2, "H"], [3, "H"], [4, "H"], [5, "H"], [6, "H"]]
# straight_flush [[2, "H"], [3, "H"], [4, "H"], [5, "H"], [7, "H"]]
# straight_flush [[2, "H"], [3, "H"], [3, "H"], [5, "H"], [6, "H"]]
def straight_flush(hand)
  flush(hand) && straight(hand)
end

# Four of a Kind: Four cards of the same value.
# puts four_of_a_kind([[2, "H"], [3, "H"], [4, "H"], [5, "H"], [6, "H"]]).inspect
# puts four_of_a_kind([[2, "H"], [3, "S"], [3, "H"], [3, "D"], [3, "C"]]).inspect
def four_of_a_kind(hand)
  if (groups = hand.map(&:first).group_by(&:itself)).detect { |val, list| list.length == 4 }
    groups.sort { |val, list| list.length }.map(&:first)
  end
end

# Full House: Three of a kind and a pair.
# puts full_house([[2, "H"], [3, "H"], [4, "H"], [5, "H"], [6, "H"]]).inspect
# puts full_house([[4, "H"], [3, "S"], [3, "H"], [4, "D"], [3, "C"]]).inspect
def full_house(hand)
  if (groups = hand.map(&:first).group_by(&:itself)).map { |val, list| list.length }.sort! == [2, 3]
    groups.sort_by { |val, list| list.length }.map!(&:first).reverse!
  end
end

# Flush: All cards of the same suit.
# puts flush([[2, "H"], [3, "H"], [4, "H"], [5, "H"], [6, "H"]]).inspect
# puts flush([[4, "H"], [3, "S"], [3, "H"], [4, "D"], [3, "C"]]).inspect
def flush(hand)
  hand.inject { |p, h| p.last == h.last ? h : (break false) } && hand.map(&:first).sort!.reverse!
end

# Straight: All cards are consecutive values.
# puts straight([[2, "H"], [3, "H"], [4, "H"], [5, "H"], [6, "H"]]).inspect
# puts straight([[2, "H"], [3, "H"], [4, "D"], [5, "H"], [6, "H"]]).inspect
# puts straight([[2, "H"], [3, "H"], [3, "H"], [5, "H"], [6, "H"]]).inspect
def straight(hand)
  hand.map(&:first).sort!.inject {|t, x| x == t + 1 ? x : (break false) } && hand.map(&:first).max
end

# Three of a Kind: Three cards of the same value.
def three_of_a_kind(hand)
  if (groups = hand.map(&:first).group_by(&:itself)).map { |val, list| list.length }.sort!.last == 3
    groups.partition { |val, list| list.length == 3 }.flat_map { |group| group.map!(&:first).sort!.reverse! }
  end
end

# Two Pairs: Two different pairs.
# puts two_pairs([[2, "H"], [3, "H"], [3, "H"], [2, "H"], [6, "H"]]).inspect
# puts two_pairs([[2, "H"], [3, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
# puts two_pairs([[2, "H"], [8, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
def two_pairs(hand)
  (r = pairs_from_hand(hand)) ? r.length == 3 && r : false
end

# One Pair: Two cards of the same value.
# puts one_pair([[2, "H"], [3, "H"], [3, "H"], [2, "H"], [6, "H"]]).inspect
# puts one_pair([[2, "H"], [3, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
# puts one_pair([[2, "H"], [8, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
def one_pair(hand)
  (r = pairs_from_hand(hand)) ? r.length == 4 && r : false
end

# puts pairs_from_hand([[2, "H"], [3, "H"], [3, "H"], [2, "H"], [6, "H"]]).inspect
# puts pairs_from_hand([[2, "H"], [3, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
# puts pairs_from_hand([[2, "H"], [8, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
def pairs_from_hand(hand)
  if (groups = hand.map(&:first).group_by(&:itself)).map { |val, list| list.length }.sort!.last == 2
    groups.partition { |val, list| list.length == 2 }.flat_map { |group| group.map!(&:first).sort!.reverse! }
  end
end

# High Card: Highest value card.
# puts high_card([[2, "H"], [8, "H"], [3, "H"], [1, "H"], [6, "H"]]).inspect
def high_card(hand)
  hand.map(&:first).sort!.reverse!
end

def compare_hands(type, hand1, hand2)
  compare send(type, hand1), send(type, hand2)
end

def compare(r1, r2)
  if !r2 && r1
    true
  elsif !r1 && r2
    false
  else
    [*r1].zip([*r2]).lazy
      .map { |val1, val2|
        case val1 <=> val2
        when -1 then false
        when 1 then true
        else nil
        end
      }
      .reject(&:nil?)
      .first
  end
end

wins_one = 0
File.open("resources/problem_54_poker.txt") do |f|
  f.each_line do |line|
    hand1, hand2 = line.split(' ').each_slice(5).to_a.map { |hand| hand.map { |card| [CARD_RANKS[card[0]], card[1]] } }

    # wins_one += 1 if  compare_hands(:straight_flush, hand1, hand2) ||
                      # compare_hands(:four_of_a_kind, hand1, hand2) ||
                      # compare_hands(:full_house, hand1, hand2) ||
                      # compare_hands(:flush, hand1, hand2) ||
                      # compare_hands(:straight, hand1, hand2) ||
                      # compare_hands(:three_of_a_kind, hand1, hand2) ||
                      # compare_hands(:two_pairs, hand1, hand2) ||
                      # compare_hands(:one_pair, hand1, hand2) ||
                      # compare_hands(:pairs_from_hand, hand1, hand2) ||
                      # compare_hands(:high_card, hand1, hand2)

    wins_one += 1 if %i[straight_flush four_of_a_kind full_house flush straight three_of_a_kind two_pairs one_pair pairs_from_hand high_card].lazy
      .map{ |type| compare_hands(type, hand1, hand2) }
      .reject(&:nil?)
      .first
  end
end
puts wins_one
