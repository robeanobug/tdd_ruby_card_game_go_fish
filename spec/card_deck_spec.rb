require_relative '../lib/card_deck'

describe 'CardDeck' do
  let(:deck) { CardDeck.new }
  # let(:card) { deck.deal }
  describe '#initialize' do
    it 'should create a deck of cards and show how many cards are left' do
      expect(deck.cards_left).to eq(CardDeck::DECK_SIZE)
    end

    it 'should deal a card' do
      expect(card.deal_card).to be_a(PlayingCard)
      expect(card.deal_card).to_not be_nil
    end
    xit 'should shuffle the deck' do
      unshuffled_deck = deck.cards.dup
      deck.shuffle!
      expect(unshuffled_deck).to_match_array deck.cards
      expect(unshuffled_deck).to_not eq deck.cards
    end
    it 'should add a card to the deck'
  end
end