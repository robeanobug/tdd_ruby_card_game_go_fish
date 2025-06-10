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
  end

  def display_hand
    # currently just puts the playing card addresses
    current_client.puts "Your cards are: #{ current_player.hand.map { |card| "#{card.rank} of #{card.suit}" } }"
  end

  def players
    game.players
  end

  def get_target
    current_client.puts "Please enter a player to target: "
    player_name = listen_to_current_client
    valid_player(player_name)
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

  def find_player(player_name)
    players.find do |player|
      player.name.downcase == player_name.downcase
    end
  end

  def valid_player(player_name)
    player = find_player(player_name)
    return player if player
    current_client.puts 'Invalid player'
    false
  end
end
