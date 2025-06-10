# require 'socket'
require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_reader :game, :players_clients
  attr_accessor :response

  def initialize(game, players_clients)
    @game = game
    @players_clients = players_clients
  end

  def play_round
    display_hand
    get_rank
    get_target
  end

  def display_hand
    current_client.puts "Your cards are: #{ current_player.hand.map { |card| "#{card.rank} of #{card.suit}" } }"
  end

  def get_rank
    current_client.puts "Please request to card rank (ex: 2 or Ace): "
    requested_rank = listen_to_current_client
    current_client.puts "You are requesting rank: #{ requested_rank }"
  end
  
  def get_target
    current_client.puts "Please enter a player to target: "
    player_name = listen_to_current_client
    player = valid_player(player_name)
    current_client.puts "Your target: #{ player_name }"
    player
  end
  
  def players
    game.players
  end

  def current_player
    game.current_player
  end
  
  private

  def current_client
    players_clients[current_player]
  end

  def listen_to_current_client(delay=0.1)
    sleep(delay)
    current_client.read_nonblock(200_000).chomp
  rescue IO::WaitReadable
    ""
  end

  def valid_player(player_name)
    player = find_player(player_name)
    return player if player
    current_client.puts 'Invalid player'
  end
  
  def find_player(player_name)
    players.find do |player|
      player.name.downcase == player_name.downcase
    end
  end
end
