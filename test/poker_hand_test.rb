require "test_helper"

class PokerHandTest < ActiveSupport::TestCase
  def royal_flush
    @_royal_flush ||= PokerHand.new "TS JS QS KS AS"
  end

  def straight_flush
    @_straight_flush ||= PokerHand.new "9S TS JS QS KS"
  end

  def flush
    @_flush ||= PokerHand.new "3S JS KS 7S TS"
  end

  def straight
    @_straight ||= PokerHand.new "TS JH QS KC AD"
  end

  def four_of_a_kind
    @_four_of_a_kind ||= PokerHand.new "3D 3C 3H 3S TS"
  end

  def full_house
    @_full_house ||= PokerHand.new "4S 4S 7D 7C 7H"
  end

  def three_of_a_kind
    @_three_of_a_kind ||= PokerHand.new "3D 3C 3H 7S TS"
  end

  def two_pair
    @_two_pair ||= PokerHand.new "7D 7C 4H 4S TS"
  end

  def pair
    @_pair ||= PokerHand.new "3D 3C 7H 4S TS"
  end

  def highest_card
    @_highest_card ||= PokerHand.new "4C JD 8C TH 9S"
  end

  def test_face_values
    assert_equal [3, 7, 8, 9, 10], highest_card.face_values
  end

  def test_royal_flush
    assert royal_flush.royal_flush?
    refute PokerHand.new("9S TS JS QS KS").royal_flush?
    refute PokerHand.new("TS JS QS KS AD").royal_flush?
  end

  def test_straight_flush
    assert straight_flush.straight_flush?
    refute PokerHand.new("7S TS JS QS KS").straight_flush?
    refute PokerHand.new("9C TS JS QS KS").straight_flush?
  end

  def test_flush
    assert flush.flush?
    refute PokerHand.new("3S JS KS 7S TD").flush?
  end

  def test_straight
    assert straight.straight?
    refute PokerHand.new("TS JH QS KC 2D").straight?
  end

  def test_four_of_a_kind
    assert four_of_a_kind.four_of_a_kind?
    refute PokerHand.new("3D 3C 3H 4S TS").four_of_a_kind?
  end

  def test_full_house
    assert full_house.full_house?
    refute PokerHand.new("3D 3C 3H 4S 5S").full_house?
  end

  def test_three_of_a_kind
    assert three_of_a_kind.three_of_a_kind?
    refute PokerHand.new("3D 3C 2H 4S TS").three_of_a_kind?
  end

  def test_two_pair
    assert two_pair.two_pair?
    refute PokerHand.new("3D 3C 7H 4S TS").two_pair?
  end

  def test_pair
    assert pair.pair?
    refute PokerHand.new("3D 8C 7H 4S TS").pair?
  end

  def test_highest_three_of_a_kind_value
    assert_equal 6, full_house.highest_three_of_a_kind_value
    assert_equal 2, three_of_a_kind.highest_three_of_a_kind_value
    assert_equal 0, pair.highest_three_of_a_kind_value
  end

  def test_highest_pair_value
    assert_equal 3, full_house.highest_pair_value
    assert_equal 0, three_of_a_kind.highest_pair_value
    assert_equal 2, pair.highest_pair_value
  end

  def test_card_values
    assert_equal 0.1098644169, highest_card.card_values
  end

  def test_score
    assert_equal 900000.144545535, royal_flush.score
    assert_equal 0.1098644169, highest_card.score
  end

  def test_to_s
    assert_equal "Royal Flush", royal_flush.to_s
    assert_equal "Straight Flush", straight_flush.to_s
    assert_equal "Four of a kind", four_of_a_kind.to_s
    assert_equal "Full house", full_house.to_s
    assert_equal "Flush", flush.to_s
    assert_equal "Straight", straight.to_s
    assert_equal "Three of a kind", three_of_a_kind.to_s
    assert_equal "Two pair", two_pair.to_s
    assert_equal "Pair", pair.to_s
    assert_equal "Highest Card", highest_card.to_s
  end

  def test_royal_flush_greater_than_straight_flush
    assert_operator royal_flush.score, :>, straight_flush.score
  end

  def test_straight_flush_greater_than_four_of_a_kind
    assert_operator straight_flush.score, :>, four_of_a_kind.score
  end

  def test_four_of_a_kind_greater_than_full_house
    assert_operator four_of_a_kind.score, :>, full_house.score
  end

  def test_full_house_greater_than_flush
    assert_operator full_house.score, :>, flush.score
  end

  def test_flush_greater_than_straight
    assert_operator flush.score, :>, straight.score
  end

  def test_straight_greater_than_three_of_a_kind
    assert_operator straight.score, :>, three_of_a_kind.score
  end

  def test_three_of_a_kind_greater_than_two_pair
    assert_operator three_of_a_kind.score, :>, two_pair.score
  end

  def test_two_pair_greater_than_pair
    assert_operator two_pair.score, :>, pair.score
  end

  def test_pair_greater_than_highest_card
    assert_operator pair.score, :>, highest_card.score
  end

  def test_straight_flush_greater_with_higher_card
    assert_operator straight_flush.score, :>, PokerHand.new("8S 9S TS JS QS").score
  end

  def test_four_of_a_kind_greater_with_higher_card
    assert_operator four_of_a_kind.score, :>, PokerHand.new("3D 3C 3H 3S 7S").score
  end

  def test_full_house_greater_with_higher_three_of_a_kind
    assert_operator full_house.score, :>, PokerHand.new("4S 4S 6D 6C 6H").score
    # higher pair
    assert_operator full_house.score, :>, PokerHand.new("9S 9S 6D 6C 6H").score
  end

  def test_full_house_greater_with_higher_pair
    assert_operator full_house.score, :>, PokerHand.new("3S 3S 7D 7C 7H").score
  end

  def test_three_of_a_kind_greater_with_higher_pair
    assert_operator three_of_a_kind.score, :>, PokerHand.new("2D 2C 2H 7S TS").score
  end

  def test_two_pair_greater_with_higher_pair
    assert_operator two_pair.score, :>, PokerHand.new("6D 6C 4H 4S TS").score
    assert_operator two_pair.score, :>, PokerHand.new("7D 7C 3H 3S TS").score
  end

  def test_pair_greater_with_higher_pair
    assert_operator pair.score, :>, PokerHand.new("2D 2C 7H 4S TS").score
  end

  def test_highest_card_greater_with_higher_cards
    assert_operator highest_card.score, :>, PokerHand.new("4C TD 8C 3H 9S").score
  end
end
