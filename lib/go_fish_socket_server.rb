require 'socket'
require_relative 'go_fish_game'
require_relative 'player'

class GoFishSocketServer
  attr_accessor :server, :games, :clients, :players, :lobbies
  attr_reader :port_number

  def initialize
    @port_number = 3336
    @server = 0
    @games ||= []
    @clients ||= []
    @players ||= []
    # @responses ||= []
    @lobbies ||= []
  end

  def accept_new_client(player_name = 'Random Player')
    client = @server.accept_nonblock
    players << Player.new(player_name)
    clients << client
    client.puts 'Welcome to Go Fish! You are in the waiting lobby. Waiting for players to join...'
    create_lobby(players[0]) if players.length == 1
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def create_lobby(host_player)
    lobbies << GoFishLobby.new(host_player)
  end

  # def create_game_if_possible
  #   if players.count > 1
  #     game = GoFishGame.new(players)
  #     game.start
  #     games << game
  #   end
  # end

  def start
    @server = TCPServer.new(port_number)
  end

  def stop
    @server.close if @server
  end
end
