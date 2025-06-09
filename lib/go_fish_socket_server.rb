require 'socket'
require_relative 'go_fish_game'
require_relative 'player'

class GoFishSocketServer
  attr_accessor :server, :games, :clients, :players, :responses
  attr_reader :port_number

  def initialize
    @port_number = 3336
    @server = 0
    @games ||= []
    @clients ||= []
    @players ||= []
    @responses ||= []
  end

  def accept_new_client(player_name = 'Random Player')
    client = @server.accept_nonblock
    player = Player.new(player_name)
    players << player
    clients << client
    client.puts 'Welcome to Go Fish!'
  rescue IO::WaitReadable, Errno::EINTR
    puts 'No client to accept'
  end

  def start
    @server = TCPServer.new(port_number)
  end

  def stop
    @server.close if @server
  end
end
