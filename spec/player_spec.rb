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

  describe '#take_cards_of_rank' do
    it 'takes cards of a certain rank from hand' do
      player.hand = [card1, card2, card3, card4]

      expect(player.take_cards_of_rank(card1.rank)).to eq([card1, card2])
      expect(player.hand).to eq([card3, card4])
      expect(player.take_cards_of_rank('10')).to eq([])
    end

    it 'takes a card of certain rank from hand' do
      player.hand = [card1, card2, card3, card4]

      expect(player.take_cards_of_rank(card3.rank)).to eq([card3])
      expect(player.hand).to eq([card1, card2, card4])
    end

    it 'returns an empty array if no ranks match' do
      player.hand = [card1, card2, card3]

      expect(player.take_cards_of_rank(card4.rank)).to eq([])
    end
  end

  # xit 'takes cards from hand' do
  #   player.hand = [card1, card2, card3, card4]
  #   found_cards = player.find_cards_of_rank(card1.rank)

  #   expect(player.take_cards(found_cards)).to eq([card3, card4])
  #   expect(player.take_cards([card1])).to eq([card2, card3, card4])
  # end

  # xit 'takes one card from a hand' do
  #   player.hand = [card1, card2, card3, card4]
  #   expect(player.take_cards([card1])).to eq([card2, card3, card4])
  # end
end
