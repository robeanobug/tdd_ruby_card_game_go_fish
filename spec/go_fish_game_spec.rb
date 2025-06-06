require_relative '../lib/go_fish_game'

describe GoFishGame do
  let(:game) { GoFishGame.new }


  it 'initializes a game' do
    game = GoFishGame.new
    expect(game).to_not be_nil
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

  describe '#deal_cards_to_players' do
    it 'deals 7 cards to 2 players' do
      game.players = [Player.new('P1'), Player.new('P2')]
      game.deal_cards_to_players
      
      expect(game.players.first.hand.length).to eq(GoFishGame::CARDS_DEALT_7)
    end

    it 'deals 5 cards to 4 players' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards_to_players
      expect(game.players.first.hand.length).to eq(GoFishGame::CARDS_DEALT_5)
    end
  end

  describe '#request_rank' do
    it 'when asking player for a valid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards_to_players
      current_player = game.players.first

      allow(game).to receive(:gets).and_return('ace')

      expect(game.request_rank(current_player)).to eq('ace')
    end
    xit 'asks a player for an invalid rank' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards_to_players
      current_player = players.first

      allow(game).to receive(:gets).and_return('foo')

      expect(request_rank(current_player)).to eq('Invalid rank')
    end
    xit 'when asking player for a valid player' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards_to_players
      current_player = players.first

      allow(game).to receive(:gets).and_return('P2')

      expect(current_player.request_rank).to eq(game.players[1])
    end
    xit 'asks a player for an invalid player' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      game.deal_cards_to_players
      current_player = players.first

      allow(game).to receive(:gets).and_return('foo')

      expect(current_player.request_rank).to eq('Invalid player')
    end
  end

  describe '#request_player' do
    it 'asks a player for a player'
  end

  describe '#play_round' do
    it 'goes through round of the game'
    it 'keeps count of each round'
  end
end
