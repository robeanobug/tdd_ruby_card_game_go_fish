require 'socket'
require_relative '../lib/go_fish_socket_server'
require_relative '../lib/mock_go_fish_socket_client'

describe GoFishSocketServer do
  before(:each) do
    @clients = []
    @server = GoFishSocketServer.new
    @server.start
    sleep 0.1
  end

  after(:each) do
    @server.stop
    @clients.each do |client|
      client.close
    end
  end

  let(:client1) { MockGoFishSocketClient.new(@server.port_number) }
  let(:client2) { MockGoFishSocketClient.new(@server.port_number) }

  it 'is not listening on a port before it is started' do
    @server.stop
    expect { MockGoFishSocketClient.new(@server.port_number)}.to raise_error(Errno::ECONNREFUSED)
  end

  it 'accepts a new client' do
    player_count = 1
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    expect(@server.players.count).to eq(player_count)
  end

  it 'accepts another new client' do
    player_count = 2
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    @clients.push(client2)
    @server.accept_new_client('Player 2')
    
    expect(@server.players.count).to eq(player_count)
  end

  it 'sends clients a welcome message' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    @clients.push(client2)
    @server.accept_new_client('Player2')

    expect(client1.capture_output).to match /welcome/i
    expect(client2.capture_output).to match /welcome/i
  end

  it 'creates lobby for the players to gather' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    @clients.push(client2)
    @server.accept_new_client('Player2')
    @server.create_game_if_possible

    expect(@server.lobby).to_not be_nil
  end

  it 'should start a game if at least 2 players' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    @clients.push(client2)
    @server.accept_new_client('Player2')
    @server.create_game_if_possible
    game_count = 1

    expect(@server.games.count).to eq(game_count)
  end

  it 'should not start a game if less than 2 players' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    @server.create_game_if_possible
    game_count = 0

    expect(@server.games.count).to eq(game_count)
  end

  xit 'should create a hash that associates player with client' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    @clients.push(client2)
    @server.accept_new_client('Player2')

    @server.create_game_if_possible
    
    expect()
  end



  # xit 'should not start game until Player 1 is ready' do # should this go in the socket server runner
  #   @clients.push(client1)
  #   @server.accept_new_client('Player 1')

  #   @clients.push(client2)
  #   @server.accept_new_client('Player2')

  #   @server.create_game_if_possible

  #   expect(@server.games.count).to eq(game_count)
  #   end
end