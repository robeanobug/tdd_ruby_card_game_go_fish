class Player
  attr_accessor :hand, :name
  def initialize(name)
    @name = name
    @hand = []
  end

  def add_card(card)
    hand << card
  end

  def find_rank(rank)
    hand.select do |card|
      card.rank == (rank)
    end
  end
end
