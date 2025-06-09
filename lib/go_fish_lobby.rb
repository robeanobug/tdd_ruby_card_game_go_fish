require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_reader :game, :players, :clients

  def initialize(game, clients)
    @game = game
    @clients = clients
  end

  def display_hand(client)
    client.puts "Your cards are: #{current_player.hand}"
  end

  def player_to_client
    player_client = Hash.new
    players.each_with_index do |player, i|
      player_client[player] = clients[i]
    end
    player_client
  end

  private

  def players
    game.players
  end

  def current_player
    game.current_player
  end
end