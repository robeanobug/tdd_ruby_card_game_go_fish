require_relative '../lib/go_fish_game'

describe GoFishGame do
  let(:game) { GoFishGame.new }

  describe '#initialize' do
    it 'initializes a game' do
      expect(game).to_not be_nil
    end

  end

  describe '#start' do
    it 'deals cards to players' do
      game.add_players('P1', 'P2')
      player1 = game.players.first
      game.start
      expect(player1.hand.length).to eq(GoFishGame::CARDS_DEALT_7)
    end
  end
  
  describe '#add_players' do
    it 'adds 2 players to players' do
      player_count = 2
      game.add_players('P1', 'P2')
      expect(game.players.length).to eq(player_count)
    end

    it 'adds 4 players to players' do
      player_count = 4
      game.add_players('P1', 'P2', 'P3', 'P4')
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

      allow(game).to receive(:gets).and_return('Ace')

      expect(game.request_rank(current_player)).to eq('Ace')
    end

    it 'asks a player for an invalid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('foo')

      expect(game.request_rank(current_player)).to be_falsey
    end

    it 'when asking player for a lowercase valid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('ace')

      expect(game.request_rank(current_player)).to eq('Ace')
    end
  end
  
  describe '#request_player' do
    it 'when asking player for a valid player uppercase' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('P2')

      expect(game.request_player(current_player)).to eq(game.players[1])
    end

    it 'when asking player for a valid player lowercase' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('p2')

      expect(game.request_player(current_player)).to eq(game.players[1])
    end

    it 'asks a player for an invalid player' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('foo')

      expect(game.request_player(current_player)).to be_falsey
    end
  end

  describe '#play_round' do
    context 'stays turn' do

      xit 'should collect cards of a certain rank from attacked player and add them to current player' do
        game.add_players('P1', 'P2')
        game.deal_cards
        current_player = game.players.first

      allow(game).to receive(:gets).and_return('foo')
        
        expect()
      end
    end
    
    context 'turn changes' do

    end

    it 'should collect cards of a certain rank from attacked player and add them to current player'
    it 'should update current_player to player 2 if starting with player 1'
  end

  describe '#update_current_player' do
    it 'should update current_player to player 2 if starting with player 1'
  end

  describe '#collect_cards' do
    it 'should collect cards of a certain rank from attacked player and add them to current player'
  end
end
