require_relative 'player'

class GoFishGame
  attr_accessor :players
  def initialize
    @players ||= []
  end

  def add_players(*names)
    names.each do |name|
      players << Player.new(name)
    end
  end
end