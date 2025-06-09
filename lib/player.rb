class Player
  attr_accessor :hand, :name, :books
  BOOK_SIZE = 4
  def initialize(name)
    @name = name
    @hand = []
    @books = []
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

  def book?
    grouped_ranks = hand.group_by { |hand| hand.rank }
    grouped_ranks.each do |rank, cards|
      return true if cards.length == BOOK_SIZE
    end
    false
  end

  private

  def delete_cards(cards)
    self.hand = hand - cards
  end
end
