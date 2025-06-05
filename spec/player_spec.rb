require_relative '../lib/player'

describe Player do
  it 'initializes player' do
    player = Player.new('name')
    expect(player.hand).to be_a(Array)
    expect(player.name).to eq('name')
  end
  
  it 'adds a card to hand'
  it 'finds a card from hand'
  it 'removes a card from hand'
end
