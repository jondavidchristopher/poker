class GamesController < ApplicationController
  def index
    render locals: { games: }
  end

  def games
    File.readlines("db/poker.txt", chomp: true).each.map do |line|
      [PokerHand.new(line.split.first(5).join " "), PokerHand.new(line.split.last(5).join " ")]
    end
  end
end
