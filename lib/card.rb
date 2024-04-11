class Card
  attr_reader :suit, :face

  SUITS = %w(C D H S)
  FACES = %w(2 3 4 5 6 7 8 9 T J Q K A)

  def self.suit_value(suite)
    SUITS.each_with_index.map { |s, i| [s, i + 1] }.to_h[suite.upcase]
  end

  def self.face_value(face)
    FACES.each_with_index.map { |f, i| [f, i + 1] }.to_h[face.upcase]
  end

  def initialize(face, suit)
    @value = "#{face}#{suit}"
    @face = self.class.face_value face
    @suit = self.class.suit_value suit
  end

  def to_s
    @value
  end
end
