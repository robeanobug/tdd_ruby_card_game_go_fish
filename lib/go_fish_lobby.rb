require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_reader :game, :players

  def initialize(game)
    @game = game
    @players = game.players
  end
end