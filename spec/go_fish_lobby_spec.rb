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
      expect(lobby).to respond_to(:play_round)
    end
  end

  describe '#play_round' do
    it 'should inform player of hand once' do
      lobby.play_round
      response = client1.capture_output

      expect(response).to match /your cards/i
      expect(PlayingCard::RANKS.any? { |rank| response.include?(rank) }).to be_truthy
      expect(PlayingCard::SUITS.any? { |suit| response.include?(suit) }).to be_truthy

      lobby.play_round
      response = client1.capture_output

      expect(response).to_not match /your cards/i
    end

    it 'should get a rank from the current player once' do
      lobby.play_round
      expect(client1.capture_output).to match /Please request to card rank/i
      client1.provide_input('Ace')
      lobby.play_round

      response = client1.capture_output

      expect(response).to match /You are requesting rank: /i

      lobby.play_round

      response = client1.capture_output
  
      expect(response).to match /Please enter a player to target:/i
      expect(response).to_not match /You are requesting rank: /i
    end

    it 'should not get a rank from the current player if the rank is invalid' do
      lobby.play_round
      expect(client1.capture_output).to match /Please request to card rank/i
      client1.provide_input('A')
      lobby.play_round

      expect(client1.capture_output).to match /Invalid rank/i
      lobby.play_round
      expect(client1.capture_output).to match /Please request to card rank/i
      lobby.play_round
      expect(client1.capture_output).to_not match /Please request to card rank/i
    end

    it 'should get a target player from the current player once' do
      lobby.play_round
      client1.provide_input('Ace')
      lobby.play_round
      client1.provide_input('Player 2')
      lobby.play_round

      response = client1.capture_output

      expect(response).to match /Please enter a player to target/i
      expect(response).to match /Your target/i

      lobby.play_round
      response = client1.capture_output

      expect(response).to_not match /Please enter a player to target/i
      expect(response).to_not match /Your target/i
    end

    it 'should not get a target player from the current player if the request is invalid' do
      lobby.play_round
      client1.provide_input('Ace')
      lobby.play_round
      client1.provide_input('foo')
      response = client1.capture_output

      expect(response).to match /Invalid player/i
    end

    it 'should output the results of a round' do
      lobby.play_round
      client1.provide_input('Ace')
      lobby.play_round
      client1.provide_input('Player 2')
      lobby.play_round

      expect(client1.capture_output).to match /Result: /i
      expect(client2.capture_output).to match /Result: /i
    end

    it 'should clear round'
  end
end

# to do:
# get get_target working
# 
# fix game.play_round output
# refactor tests
# 
# questions
# 
# 