require_relative '../lib/player'

describe Player do
  let (:player) { Player.new('P1') }
  it 'initializes player' do
    expect(player.hand).to be_a(Array)
    expect(player.name).to eq('P1')
  end
  describe '#add_card' do
    it 'adds a card to hand' do
      player.add_card(PlayingCard.new('1', 'Spades'))

      expect(player.hand.length).to eq(1)
    end
  end

  it 'finds a card from hand'
  it 'removes a card from hand'
end
