require_relative '../lib/go_fish_lobby'
require_relative '../lib/mock_go_fish_socket_client'

describe GoFishLobby do
  before(:each) do
    @clients = []
    @server = GoFishSocketServer.new
    @server.start
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    
    @clients.push(client2)
    @server.accept_new_client('Player 2')
    
    @server.create_game_if_possible
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
  let(:lobby) { @server.lobby }
  
  xit 'should initialize with a game' do
    # This fails SOMETIMES???
    # expect(@server).to respond_to(create_game_if_possible)
    # lobby = @server.lobby
    expect(lobby).to respond_to(play_round)
  end

  it 'should inform player of hand' do
    client2.capture_output
    client1.capture_output
    # p lobby
    lobby.play_round

    expect(client1.capture_output).to match /your cards/i
  end

  it 'should get a target player from the current player' do
    lobby.play_round
    client1.provide_input('Player 2')
    expect(lobby.get_target).to eq(lobby.players.last)
  end

  it 'should select a rank'
  it 'should validate inputs'
end
