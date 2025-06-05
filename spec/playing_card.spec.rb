require_relative '../lib/playing_card'

describe 'PlayingCard' do
  describe '#initialize' do
    it 'should initialize a card with a suit and rank' do
      card = PlayingCard.new('Ace', 'Spades')
      expect(card).to be_a(PlayingCard)
      expect(card).to_not be_nil
    end
  end
  
  describe '==' do
    it 'should return true when 2 cards are equal' do
      card1 = PlayingCard.new('Ace', 'Spades')
      card2 = PlayingCard.new('Ace', 'Spades')

      expect(card1).to eq(card2)
    end
  end

  describe 'to_value' do
    it 'should return the value of the card' do
      card = Card.new('Ace', 'Spades')

      expect(card.to_value).to eq(12)
    end
  end
  
end