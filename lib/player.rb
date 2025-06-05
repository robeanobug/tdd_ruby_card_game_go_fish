class Player
  attr_accessor :hand, :name
  def initialize(name)
    @name = name
    @hand = []
  end

  def add_card(card)
    hand << card
  end

  def take_cards_of_rank(rank)
    found_cards = hand.select do |card|
      card.rank == (rank)
    end
    delete_cards(found_cards)
    found_cards
  end

  private

  def delete_cards(cards)
    self.hand = hand - cards
  end
end
