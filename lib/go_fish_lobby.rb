require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_reader :game, :players_clients
  attr_accessor :response, :hand_displayed, :requested_rank_displayed, :requested_player, :rank, :target

  def initialize(game, players_clients)
    @game = game
    @players_clients = players_clients
  end

  def play_round
    display_hand unless hand_displayed
    get_rank
    self.target = get_target if rank && !target
    result = game.play_round(target.name, rank) if rank && target
    send_message_to_all_clients("Result: #{result}") if result
  end

  private

  def display_hand
    current_client.puts "Your cards are: #{ current_player.hand.map { |card| "#{card.rank} of #{card.suit}" } }"
    self.hand_displayed = true
  end

  def get_rank
    return if rank
    current_client.puts "Please request to card rank (ex: 2 or Ace): " unless requested_rank_displayed
    self.requested_rank_displayed = true
    requested_rank = listen_to_current_client
    # binding.irb
    if requested_rank && valid_rank?(requested_rank)
      current_client.puts "You are requesting rank: #{ requested_rank }"
      self.rank = requested_rank
    elsif requested_rank && !valid_rank?(requested_rank)
      self.requested_rank_displayed = false
    end
  end
  
  def get_target
    current_client.puts "Please enter a player to target: " unless requested_player
    player_name = listen_to_current_client
    self.requested_player = valid_player(player_name)
    current_client.puts "Your target is: #{ player_name }"  unless requested_player
    requested_player
  end

  def players
    game.players
  end

  def current_player
    game.current_player
  end

  def current_client
    players_clients[current_player]
  end

  def listen_to_current_client(delay=0.1)
    sleep(delay)
    current_client.read_nonblock(200_000).chomp
  rescue IO::WaitReadable
    nil
  end

  def valid_player(player_name)
    player = find_player(player_name)
    return player if player
    current_client.puts 'Invalid player'
  end
  
  def find_player(player_name)
    players.find do |player|
      player.name.downcase == player_name.to_s.downcase
    end
  end

  def valid_rank?(rank)
    return true if PlayingCard::RANKS.include?(rank)
    current_client.puts 'Invalid rank'
  end

  def send_message_to_all_clients(message)
    clients.each { |client| client.puts message }
  end

  def clients
    players_clients.values
  end
end
