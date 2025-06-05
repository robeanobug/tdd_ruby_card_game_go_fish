require_relative '../lib/go_fish_game'

describe GoFishGame do
  it 'initializes a game' do
    game = GoFishGame.new
    expect(game).to_not be_nil
  end

  it 'asks player for a card'

end
