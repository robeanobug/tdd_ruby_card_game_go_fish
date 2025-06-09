require_relative '../lib/go_fish_lobby'
require_relative '../lib/mock_go_fish_socket_client'

describe GoFishLobby do
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

  xit 'should initialize with a game' do
    player1 = Player.new('p1')
    player2 = Player.new('p2')
    game = GoFishGame.new([player1, player2])
    lobby = GoFishLobby.new(game)

    expect(lobby.game).to_not be_nil
    expect(lobby.players).to_not be_nil
  end

  it 'should create a hash that associates player with client' do
    player1 = Player.new('p1')
    player2 = Player.new('p2')
    game = GoFishGame.new([player1, player2])
    
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    
    @clients.push(client2)
    @server.accept_new_client('Player2')
    
    lobby = GoFishLobby.new(game, @clients)
    @server.create_game_if_possible

    expect(lobby.player_to_client[game.players[0]]).to eq(client1)
  end

  it 'should inform player of hand' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    @clients.push(client2)
    @server.accept_new_client('Player2')
    @server.create_game_if_possible

    expect(client1.capture_output).to match /your cards/i
  end

  xit 'should get a target player from the current player' do
    @clients.push(client1)
    @server.accept_new_client('p1')

    @clients.push(client2)
    @server.accept_new_client('p2')

    @server.create_game_if_possible
    @server.run_game

    # client1.provide_input
    expect()
  end
  it 'should select a rank'
  it 'should validate inputs'
end