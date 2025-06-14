class Player
  attr_accessor :hand, :name, :books
  BOOK_SIZE = 4
  def initialize(name)
    @name = name
    @hand = []
    @books = []
  end

  def add_card(cards)
    if cards.is_a?(PlayingCard)
      hand << cards
    else
      cards.each { |card| hand << card } if cards
    end
  end

  def take_cards_of_rank(rank)
    found_cards = hand.select do |card|
      card.rank == (rank)
    end
    delete_cards(found_cards)
    found_cards
  end

  def find_book
    grouped_ranks = hand.group_by { |hand| hand.rank }
    grouped_ranks.each do |rank, cards|
      return cards if cards.length == BOOK_SIZE
    end
    false
  end

  def add_book(book)
    delete_cards(book)
    books << book
  end

  private

  def delete_cards(cards)
    self.hand = hand - cards
  end
end
