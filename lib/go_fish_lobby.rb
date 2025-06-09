# require 'socket'
require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_reader :game, :players, :clients

  def initialize(game, clients)
    @game = game
    @clients = clients
  end

  def play_round
    display_hand
  end

  def display_hand
    current_client.puts "Your cards are: #{current_player.hand}"
  end

  def player_to_client
    player_client = Hash.new
    players.each_with_index do |player, i|
      player_client[player] = clients[i]
    end
    player_client
  end

  def players
    game.players
  end

  private

  def current_player
    game.current_player
  end

  def current_client
    player_to_client[current_player]
  end
end