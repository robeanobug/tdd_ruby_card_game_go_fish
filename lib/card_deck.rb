require_relative 'playing_card'

class CardDeck
  DECK_SIZE = 52
  attr_accessor :cards
  def initialize
    @cards = build_deck.shuffle!
  end

  def build_deck
    PlayingCard::RANKS.flat_map do |rank|
      PlayingCard::SUITS.map do |suit|
        PlayingCard.new(rank, suit)
      end
    end
  end

  def cards_left
    cards.length
  end

  def deal_card
    cards.pop
  end

  def shuffle!
    cards.shuffle!
  end
end