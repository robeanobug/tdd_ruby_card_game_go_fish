require_relative '../lib/player'

describe Player do
  let (:player) { Player.new('P1') }
  let (:card1) { PlayingCard.new('2', 'Spades') }
  let (:card2) { PlayingCard.new('2', 'Hearts') }
  let (:card3) { PlayingCard.new('5', 'Spades') }
  let (:card4) { PlayingCard.new('3', 'Clubs') }
  

  it 'initializes player' do
    expect(player.hand).to be_a(Array)
    expect(player.name).to eq('P1')
  end

  describe '#add_card' do
    it 'adds a card to hand' do
      player.add_card(card1)
      expect(player.hand[0]).to eq(card1)
    end
  end
  describe '#find_rank' do
    it 'finds a card of a certain rank from hand' do
      player.hand = [card1, card2, card3, card4]

      expect(player.find_rank(card1.rank)).to eq([card1, card2])
      expect(player.find_rank('10')).to eq([])
    end
  end
  it 'removes a card from hand'
end
