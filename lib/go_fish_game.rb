require_relative 'player'
require_relative 'card_deck'
require_relative 'playing_card'

class GoFishGame
  STD_PLAYER_AMT = 3
  CARDS_DEALT_7 = 7
  CARDS_DEALT_5 = 5

  attr_accessor :players, :deck, :current_player

  def initialize(deck = CardDeck.new, players)
    @players = players
    @deck = deck
    @current_player = players.first
  end

  def start
    deal_cards
  end

  def play_round(target_name, request)
    request_rank(current_player, request)
    target = request_player(current_player, target_name)
    requested_cards = target.take_cards_of_rank(request)
    p "requested cards before adding to current player: #{requested_cards}"
    unless requested_cards.empty?
      requested_cards.each { |requested_card| current_player.add_card(requested_card) }
    end
    p "requested cards after adding to current player: #{requested_cards}"
    if requested_cards.empty?
      fished_card = go_fish
      current_player.add_card(fished_card)
      return change_turns unless fished_card.rank == request
    end
    return change_turns unless requested_cards.empty?
  end

  def change_turns
    player_index = (players.find_index(current_player) + 1) % players.length
    self.current_player = players[player_index]
  end

  def go_fish
    deck.deal_card
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

  def request_rank(current_player, rank)
    # puts 'Current Player, enter the rank you would like to collect: '
    return rank if valid_rank?(rank)
  end

  def request_player(current_player, player_name)
    # puts 'Current Player, enter the name of the player you would like to collect from: '
    valid_player(player_name)
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

  def find_player(player_name) # to add in the runner class
    players.find do |player|
      player.name.downcase == player_name
    end
  end
end
