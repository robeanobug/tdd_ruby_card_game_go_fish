require 'socket'
require_relative 'go_fish_game'
require_relative 'player'
require_relative 'go_fish_lobby'

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
    client = server.accept_nonblock
    players << Player.new(player_name)
    clients << client
    client.puts 'Welcome to Go Fish! Waiting for players to join...'
  rescue IO::WaitReadable, Errno::EINTR
    # puts 'No client to accept'
  end

  def create_game_if_possible
    if players.count > 1
      game = GoFishGame.new(players)
      game.start
      games << game
      players_clients = players_to_clients
      self.lobby = GoFishLobby.new(game, players_clients)
      puts "Creating game..."
    end
  end

  def players_to_clients
    player_client = Hash.new
    players.each_with_index do |player, i|
      player_client[player] = clients[i]
    end
    player_client
  end

  def run_game(lobby)
    puts 'running game...'
    loop do
    lobby.play_round
    end
  end

  def start
    self.server = TCPServer.new(port_number)
  end

  def stop
    server.close if server
  end
end
