require_relative 'player'
require_relative 'card_deck'
require_relative 'playing_card'

class GoFishGame
  STD_PLAYER_AMT = 3
  CARDS_DEALT_7 = 7
  CARDS_DEALT_5 = 5
  attr_accessor :players, :deck
  def initialize(deck = CardDeck.new)
    @players ||= []
    @deck = deck
  end

  def add_players(*names)
    names.each do |name|
      players << Player.new(name)
    end
  end

  def deal_cards_to_players
    dealt_cards = deal_cards_to_game
    until dealt_cards.empty?
      players.each do |player|
        player.add_card(dealt_cards.pop)
      end
    end
  end

  def deal_cards_to_game
    dealt_cards = []

    if players.length > STD_PLAYER_AMT
      (CARDS_DEALT_5 * players.length).times { dealt_cards.push(deck.deal_card) }
    else
      (CARDS_DEALT_7 * players.length).times { dealt_cards.push(deck.deal_card) }
    end
    dealt_cards
  end
end
