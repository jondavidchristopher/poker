require "test_helper"

class CardTest < ActiveSupport::TestCase
  def two_of_clubs
    @_two_of_clubs ||= Card.new "2", "C"
  end

  def ace_of_spades
    @_ace_of_spades ||= Card.new "A", "S"
  end

  def test_class_face_value
    assert_equal 1,  Card.face_value('2')
    assert_equal 13, Card.face_value('A')
  end

  def test_class_suit_value
    assert_equal 1,  Card.suit_value('C')
    assert_equal 4, Card.suit_value('S')
  end

  def test_face_value
    assert_equal 1, two_of_clubs.face
    assert_equal 13, ace_of_spades.face
  end

  def test_suit_value
    assert_equal(1, two_of_clubs.suit)
    assert_equal(4, ace_of_spades.suit)
  end
end
