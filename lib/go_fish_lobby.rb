require_relative 'player'
require_relative 'go_fish_socket_server'
require_relative 'go_fish_game'

class GoFishLobby
  attr_accessor :players
  attr_reader :host

  def initialize(host)
    @host = host
    @players = [host]
  end
end