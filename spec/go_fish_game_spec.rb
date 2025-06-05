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

  describe '#go_fish' do
    it 'asks player for a card'
  end
end
