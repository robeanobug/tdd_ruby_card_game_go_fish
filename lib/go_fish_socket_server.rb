require 'socket'
require_relative 'go_fish_game'
require_relative 'player'

class GoFishSocketServer
  attr_accessor :server, :games, :clients, :players, :lobby
  attr_reader :port_number

  def initialize
    @port_number = 3336
    @games = []
    @clients = []
    @players = []
  end

  def accept_new_client(player_name = 'Random Player')
    client = @server.accept_nonblock
    players << Player.new(player_name, client)
    clients << client
    client.puts 'Welcome to Go Fish! Waiting for players to join...'
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  # def create_lobby(host_player, lobby_index)
  #   lobbies[lobby_index] = GoFishLobby.new(host_player)
  # end

  def create_game_if_possible
    if players.count > 1
      game = GoFishGame.new(players)
      game.start
      games << game
      self.lobby = GoFishLobby.new(game, clients)
    end
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def stop
    @server.close if @server
  end
end
