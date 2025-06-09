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

  before(:each) do
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    
    @clients.push(client2)
    @server.accept_new_client('Player2')
    
    @server.create_game_if_possible
  end
  
  xit 'should initialize with a game' do

    expect(lobby.game).to_not be_nil
    expect(lobby.players).to_not be_nil
  end

  xit 'should create a hash that associates player with client' do
    lobby = @server.lobby
    # client2.capture_output
    # client1.capture_output
    # binding.irb
    expect(lobby.player_to_client[lobby.players.first]).to eq(client1)
  end

  it 'should inform player of hand' do
    lobby = @server.lobby
    client2.capture_output
    client1.capture_output
    lobby.play_round

    expect(client1.capture_output).to match /your cards/i
  end

  xit 'should get a target player from the current player' do
    @server.run_game

    # client1.provide_input
    expect()
  end
  it 'should select a rank'
  it 'should validate inputs'
end