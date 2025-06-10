require_relative '../lib/go_fish_game'

describe GoFishGame do
  let (:p1) { Player.new('p1') }
  let (:p2) { Player.new('p2') }
  let(:game) { GoFishGame.new([p1, p2]) }

  describe '#initialize' do
    it 'initializes a game' do
      expect(game).to_not be_nil
    end

    it 'initializes deck' do
      expect(game.deck).to_not be_nil
    end
    
    it 'initializes a current_player' do
      expect(game.current_player).to_not be_nil
    end
  end

  describe '#start' do
    it 'deals cards to players' do
      game.start
      expect(p1.hand.length).to eq(GoFishGame::CARDS_DEALT_7)
    end

    it 'should assign a current player' do
      game.start

      expect(game.current_player).to eq(game.players.first)
    end
  end
  
  describe '#add_players' do
    it 'adds 2 players to players' do
      player_count = 2
      expect(game.players.length).to eq(player_count)
    end

    it 'adds 4 players to players' do
      player_count = 4
      game.add_players('P3', 'P4')
      expect(game.players.length).to eq(player_count)
    end
  end

  describe '#deal_cards' do
    it 'deals 7 cards to 2 players' do
      game.players = [Player.new('P1'), Player.new('P2')]
      game.deal_cards
      
      expect(game.players.first.hand.length).to eq(GoFishGame::CARDS_DEALT_7)
    end

    it 'deals 5 cards to 4 players' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      expect(game.players.first.hand.length).to eq(GoFishGame::CARDS_DEALT_5)
    end
  end

  describe '#request_rank' do
    it 'when asking player for a valid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      expect(game.request_rank(current_player, 'Ace')).to eq('Ace')
    end

    it 'asks a player for an invalid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      expect(game.request_rank(current_player, 'foo')).to be_falsey
    end

    it 'ask a target for a valid rank, but the asking player does not have rank in hand'
  end
  
  describe '#request_player' do
    it 'should return target for a target player request' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      expect(game.request_player(current_player, 'p2')).to eq(game.players[1])
    end

    it 'should return false value for an invalid player request' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      expect(game.request_player(current_player, 'foo')).to be_falsey
    end
  end

  describe '#play_round' do
    let(:ace_hearts) { PlayingCard.new('Ace', 'Hearts') }
    let(:king_hearts) { PlayingCard.new('King', 'Hearts') }
    let(:ace_clubs) { PlayingCard.new('Ace', 'Clubs') }
    let(:king_clubs) { PlayingCard.new('King', 'Clubs')}
    let(:ace_diamonds) { PlayingCard.new('Ace', 'Diamonds') }
    let(:ace_spades) { PlayingCard.new('Ace', 'Spades') }

    before(:example) do
      game.start
      game.deck.cards = CardDeck.new.build_deck
    end

    context 'stays turn' do
      it 'should request card rank, target has it, does not complete a book' do
        game.players.first.hand = [ace_hearts, king_hearts]
        game.players.last.hand = [ace_clubs, king_clubs]
        game.play_round('p2', 'Ace')

        expect(game.players.first.hand).to eq([ace_hearts, king_hearts, ace_clubs])
        expect(game.players.last.hand).to match_array([king_clubs])
      end


      it 'should request card rank, target does not have it, card is fished and is not a book' do
        game.players.first.hand = [ace_hearts, king_hearts]
        game.players.last.hand = [king_clubs]
        game.play_round('p2', 'Ace')

        expect(game.current_player.hand).to eq([ace_hearts, king_hearts, ace_clubs])
        expect(game.players.last.hand).to eq([king_clubs])
      end

      it 'should request card rank, target has it, completes a book, there are not deck_size/books_size books' do
        game.players.first.hand = [ace_hearts, king_hearts, ace_spades]
        game.players.last.hand = [ace_clubs, king_clubs, ace_diamonds]
        game.play_round('p2', 'Ace')

        expect(game.players.first.hand).to match_array([king_hearts])
        expect(game.players.last.hand).to match_array([king_clubs])
        expect(game.players.first.books.first).to match_array([ace_spades, ace_hearts, ace_diamonds, ace_clubs])
      end

      it 'should request card rank, target does not have it, card is fished and completes a book, there are not deck_size/books_size books'
      it 'should request card rank, target does not have it, card is fished, completes a book, there are deck_size/books_size books'
    end

    context 'turn changes' do
      it 'should request card rank, target does not have it, card is not fished' do
        game.players.first.hand = [ace_hearts, king_hearts]
        game.players.last.hand = [king_clubs]
        game.play_round('p2', '10')
        
        expect(game.players.first.hand).to eq([ace_hearts, king_hearts, ace_clubs])
        expect(game.players.last.hand).to eq([king_clubs])
        expect(game.current_player).to eq(game.players.last)
      end
    end
    
    context 'deck is out' do
      xit 'should request card rank, target does not have it, deck is out' do
        game.players.first.hand = [ace_hearts, king_hearts]
        game.players.last.hand = [king_clubs]
        game.deck.cards = []
        game.play_round('p2', '10')
  
        expect(game.players.first.hand).to eq([ace_hearts, king_hearts])
      end
    end

    context 'player does not have cards' do
      it 'should draw a card before turn starts'
    end
    
    context 'game over' do
      it 'should request card rank, target does not have it, deck is out, all cards are books'
      it 'should request card rank, target has it, completes a book, there are deck_size/books_size books'
    end
  end
end
