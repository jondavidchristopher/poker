class PokerHand
  attr_reader :hand

  HANDS = [
    ["Royal Flush", :royal_flush?],
    ["Straight Flush", :straight_flush?],
    ["Four of a kind", :four_of_a_kind?],
    ["Full house", :full_house?],
    ["Flush", :flush?],
    ["Straight", :straight?],
    ["Three of a kind", :three_of_a_kind?],
    ["Two pair", :two_pair?],
    ["Pair", :pair?],
    ["Highest Card", :highest_card?],
  ]

  def initialize(cards)
    @hand = cards.split.map { |card| Card.new card[0...-1], card.last }
  end

  def face_values
    @_face_values ||= @hand.map { |c| c.face }.sort
  end

  def suit_values
    @_suit_values ||= @hand.map { |card| card.suit }.sort
  end

  def royal_flush?
    straight_flush? and face_values.last == Card::FACES.size
  end

  def straight_flush?
    flush? and straight?
  end

  def flush?
    suit_values.uniq.size <= 1
  end

  def straight?
    face_values.each_cons(2).all? { |x, y| y == x + 1 }
  end

  def four_of_a_kind?
    face_values.group_by { |e| e }.map { |_, v| v.length }.max >= 4
  end

  def full_house?
    face_values.uniq.size == 2
  end

  def three_of_a_kind?
    face_values.group_by { |e| e }.map { |_, v| v.length }.max == 3
  end

  def two_pair?
    face_values.uniq.size <= 3
  end

  def pair?
    face_values.group_by { |e| e }.map { |_, v| v.length }.max == 2
  end

  def highest_card?
    true
  end

  # Group By Face Value, then map to [count, face_value] where count == 3
  def highest_three_of_a_kind_value
    face_values.group_by { |f| f }.map { |f, v| [v.length, f] }.find { |count, f| count == 3 }&.last || 0
  end

  # Group By Face Value, then map to [count, face_value] where count == 2
  def highest_pair_value
    face_values.group_by { |f| f }.map { |f, v| [v.length, f] }.select { |count, f| count == 2 }&.last&.last || 0
  end

  def lowest_pair_value
    face_values.group_by { |f| f }.map { |f, v| [v.length, f] }.select { |count, f| count == 2 }&.first&.last || 0
  end

  def card_values
    @hand.map { |c| [c.face, c.suit] }.sort.each_with_index.map { |c, i| ((c.first * 10) + c.second) * (10 * (i + 1)) }.sum
  end

  def to_s
    HANDS.find { |h| send h.second }&.first || "Nada"
  end

  def score
    hand_score = HANDS.count - (HANDS.each_with_index.find { |h, i| send h.second }&.second) - 1
    (hand_score * 10000000) + (highest_three_of_a_kind_value * 1000000) + (highest_pair_value * 100000) + (lowest_pair_value * 50000) + card_values
  end
end
