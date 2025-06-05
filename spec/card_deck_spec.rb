require_relative '../lib/card_deck'

describe 'CardDeck' do
  let(:deck) { CardDeck.new }

  describe '#initialize' do
    it 'should create a deck of cards and show how many cards are left' do
      expect(deck.cards_left).to eq(CardDeck::DECK_SIZE)
    end
  end

  describe '#deal_card' do
    it 'should deal a card' do
      expect(deck.deal_card).to be_a(PlayingCard)
      expect(deck.deal_card).to_not be_nil
    end
  end
  
  describe '#shuffle!' do
    it 'should shuffle the deck' do
      unshuffled_deck = deck.cards.dup
      deck.shuffle!
      expect(unshuffled_deck).to match_array deck.cards
      expect(unshuffled_deck).to_not eq deck.cards
    end
  end
end