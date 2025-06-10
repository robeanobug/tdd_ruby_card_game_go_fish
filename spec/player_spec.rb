require_relative '../lib/player'

describe Player do
  let(:player) { Player.new('P1') }
  let(:two_spades) { PlayingCard.new('2', 'Spades') }
  let(:two_hearts) { PlayingCard.new('2', 'Hearts') }
  let(:five_spades) { PlayingCard.new('5', 'Spades') }
  let(:three_clubs) { PlayingCard.new('3', 'Clubs') }
  let(:two_diamonds) { PlayingCard.new('2', 'Diamonds') }
  let(:two_clubs) { PlayingCard.new('2', 'Clubs') }
  
  it 'initializes player with hand, name, books, client' do
    expect(player.hand).to be_a(Array)
    expect(player.name).to eq('P1')
    expect(player.books).to be_a(Array)
    # expect(player.client).to_not be_nil
  end

  describe '#add_card' do
    it 'adds a card to hand' do
      player.add_card(two_spades)
      expect(player.hand[0]).to eq(two_spades)
    end

    it 'adds multiple cards to a hand' do
      hand_length = 4
      player.add_card([two_spades, two_hearts, two_diamonds, two_clubs])

      expect(player.hand.length).to eq(hand_length)
    end
  end

  describe '#take_cards_of_rank' do
    it 'takes cards of a certain rank from hand' do
      player.hand = [two_spades, two_hearts, five_spades, three_clubs]

      expect(player.take_cards_of_rank(two_spades.rank)).to eq([two_spades, two_hearts])
      expect(player.hand).to eq([five_spades, three_clubs])
      expect(player.take_cards_of_rank('10')).to eq([])
    end

    it 'takes a card of certain rank from hand' do
      player.hand = [two_spades, two_hearts, five_spades, three_clubs]

      expect(player.take_cards_of_rank(five_spades.rank)).to eq([five_spades])
      expect(player.hand).to eq([two_spades, two_hearts, three_clubs])
    end

    it 'returns an empty array if no ranks match' do
      player.hand = [two_spades, two_hearts, five_spades]

      expect(player.take_cards_of_rank(three_clubs.rank)).to eq([])
    end
  end

  describe '#find_book' do
    it 'should return true if player.hand has 4 of a kind' do
      player.hand = [two_spades, two_hearts, five_spades, three_clubs, two_diamonds, two_clubs]
  
      expect(player.find_book).to be_truthy
    end
    it 'should return false if player.hand does not have 4 of a kind' do
      player.hand = [two_spades, five_spades, three_clubs, two_diamonds, two_clubs]
  
      expect(player.find_book).to be_falsey
    end
  end
  
  describe '#add_book' do
    it 'should add a book to books and remove from the hand of player' do
      player.hand = [two_spades, two_hearts, five_spades, three_clubs, two_diamonds, two_clubs]
      book = player.find_book
      player.add_book(book)

      expect(player.books).to match_array([[two_spades, two_hearts, two_diamonds, two_clubs]])
      expect(player.hand).to match_array([five_spades, three_clubs])
    end
  end
end
