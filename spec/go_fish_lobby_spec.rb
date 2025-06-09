require_relative '../lib/go_fish_lobby'

describe GoFishLobby do
  it 'initializes with a host player' do
    host = Player.new('p1')
    lobby = GoFishLobby.new(host)

    expect(lobby.host).to eq(host)
    expect(lobby.players).to be_a(Array)
  end

  it 'starts the game when the host is ready and there are at least 2 players' do
    
  end

  xit 'should not start a game if less than 2 players' do
    @clients.push(client1)
    @server.accept_new_client('Player 1')
    @server.create_game_if_possible
    game_count = 0

    expect(@server.games.count).to eq(game_count)
  end
  
  xit 'should not start game until Player 1 is ready' do # should this go in the socket server runner
    @clients.push(client1)
    @server.accept_new_client('Player 1')

    @clients.push(client2)
    @server.accept_new_client('Player2')

    @server.create_game_if_possible
  end
end