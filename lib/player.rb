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
    found_cards = hand.select do |card|
      card.rank == (rank)
    end
    # take_cards(found_cards)
  end

  def take_cards(cards)
    hand - cards
  end
end
