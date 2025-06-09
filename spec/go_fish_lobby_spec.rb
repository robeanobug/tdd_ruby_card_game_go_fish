require_relative '../lib/go_fish_lobby'

describe GoFishLobby do
  it 'initializes with a host player' do
    host = Player.new('p1')
    lobby = GoFishLobby.new(host)

    expect(lobby.host).to eq(host)
    expect(lobby.players).to be_a(Array)
  end
end