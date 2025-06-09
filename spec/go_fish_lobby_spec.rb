require_relative '../lib/go_fish_lobby'

describe GoFishLobby do
  it 'should initialize with a game' do
    player1 = Player.new('p1')
    player2 = Player.new('p2')
    game = GoFishGame.new([player1, player2])
    lobby = GoFishLobby.new(game)

    expect(lobby.game).to_not be_nil
    expect(lobby.players).to_not be_nil
  end

  xit 'should inform player of hand' do
  
    expect(game.current_player.client.capture_output).to match /your cards/i
  end

  xit 'should get a target player from the current player' do
    @clients.push(client1)
    @server.accept_new_client('p1')

    @clients.push(client2)
    @server.accept_new_client('p2')

    @server.create_game_if_possible
    @server.run_game

    allow(@server).to receive(:gets).and_return('p2')
    allow(@server).to receive(:gets).and_return('Ace')

    expect()
  end
  it 'should select a rank'
  it 'should validate inputs'
end