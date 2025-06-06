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

  def deal_cards
    how_many_cards_to_deal.times do
      players.each do |player|
        card = deck.deal_card
        player.add_card(card)
      end
    end
  end

  def request_rank(current_player)
    puts 'Current Player, enter the rank you would like to collect: '
    requested_rank = gets.capitalize.chomp
    return requested_rank if valid_rank?(requested_rank)
  end

  def request_player(current_player)
    puts 'Current Player, enter the name of the player you would like to collect from: '
    requested_player_name = gets.downcase.chomp
    valid_player(requested_player_name)
  end

  private

  def how_many_cards_to_deal
    if players.length > STD_PLAYER_AMT
      CARDS_DEALT_5
    else
      CARDS_DEALT_7
    end
  end

  def valid_rank?(requested_rank)
    return true if PlayingCard::RANKS.include?(requested_rank)
    puts 'Invalid rank'
  end

  def valid_player(player_name)
    player = find_player(player_name)
    return player if player
    puts 'Invalid player'
  end

  def find_player(player_name)
    players.find do |player|
      player.name.downcase == player_name
    end
  end
end
