require_relative '../lib/card'

describe 'Card' do
  describe '#initialize' do
    it 'should initialize a card with a suit and rank' do
      card = Card.new('Ace', 'Spades')
      expect(card).to be_a(Card)
      expect(card).to_not be_nil
    end
  end
  
  describe '==' do
    it 'should return true when 2 cards are equal' do
      card1 = Card.new('Ace', 'Spades')
      card2 = Card.new('Ace', 'Spades')

      expect(card1).to eq(card2)
    end
  end
  describe 'to_value' do
    it 'should return the value of the card'
  end
end