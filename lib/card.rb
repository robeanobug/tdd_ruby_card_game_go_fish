class Card
  attr_reader :rank, :suit
  RANKS = %w[Spades Hearts Diamonds Clubs]
  SUITS = %w[2 3 4 5 6 7 8 9 10 Jack Queen King Ace]

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def ==(other_card)
    rank == other_card.rank &&
    suit == other_card.suit
  end
end