require_relative '../lib/go_fish_lobby'
require_relative '../lib/mock_go_fish_socket_client'

describe GoFishLobby do
  before(:each) do
    @clients = []
    @server = GoFishSocketServer.new
    @server.start
    sleep 0.1
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    
    @clients.push(client2)
    @server.accept_new_client('Player 2')
    
    @server.create_game_if_possible
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

  describe '#initialize' do
    it 'should initialize with a game' do
      # This fails SOMETIMES???
      # expect(@server).to respond_to(create_game_if_possible)
      # lobby = @server.lobby
      expect(lobby).to respond_to(:play_round)
    end
  end

  describe '#play_round' do
    it 'should inform player of hand' do
      client2.capture_output
      client1.capture_output
      lobby.play_round
      response = client1.capture_output
      expect(response).to match /your cards/i
      expect(PlayingCard::RANKS.any? { |rank| response.include?(rank) }).to be_truthy
      expect(PlayingCard::SUITS.any? { |suit| response.include?(suit) }).to be_truthy
    end

    it 'should get a rank from the current player' do
      lobby.play_round
      client1.provide_input('Ace')

      expect(client1.capture_output).to match /You are requesting rank: /i
    end

    xit 'should not get a rank from the current player if the rank is invalid' do
      lobby.play_round
      client1.provide_input('Ace')

      expect(client1.capture_output).to match /Invalid rank/i
    end

    it 'should get a target player from the current player' do
      lobby.play_round
      client1.provide_input('Ace')
      lobby.play_round
      client1.provide_input('Player 2')
      expect(lobby.get_target).to eq(lobby.players.last)
      expect(client1.capture_output).to match /Player 2/i
    end

    it 'should not get a target player from the current player if the request is invalid' do
      lobby.play_round
      client1.provide_input('Ace')
      lobby.play_round
      client1.provide_input('foo')

      expect(client1.capture_output).to match /Invalid player/i
    end
  end
end
