require_relative '../lib/go_fish_game'

describe GoFishGame do
  let(:game) { GoFishGame.new }

  it 'initializes a game' do
    game = GoFishGame.new
    expect(game).to_not be_nil
  end

  describe '#add_players' do
    it 'adds 2 players to players' do
      game.add_players('P1', 'P2')
      expect(game.players.length).to eq(2)
    end

    it 'adds 4 players to players' do
      game.add_players('P1', 'P2', 'P3', 'P4')
      expect(game.players.length).to eq(4)
    end
  end

  describe '#deal_cards' do
    it 'deals 7 cards to 2 players' do

    end

    it 'deals 5 cards to 4 players'
  end

  it 'asks player for a card'

end
