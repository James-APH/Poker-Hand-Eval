defmodule PokerHandEval.Deck do
  @moduledoc """
    Provides methods for creating and handling a deck of cards
  """
  alias PokerHandEval.Card, as: Card

  @doc """
    Returns a list of strings representing the various types
    of cards in a standard deck of playing cards.
  """
  @spec types() :: %{atom() => integer()}
  def types() do
    %{
      Two: 2,
      Three: 3,
      Four: 4,
      Five: 5,
      Six: 6,
      Seven: 7,
      Eight: 8,
      Nine: 9,
      Ten: 10,
      Jack: 11,
      Queen: 12,
      King: 13,
      Ace: 14
    }
  end

  @doc """
    Returns a list of strings representing the various types
    of suits in a standard deck of playing cards.
  """
  @spec suits() :: [atom()]
  def suits() do
    [:Spades, :Clubs, :Hearts, :Diamonds]
  end

  @doc """
    Returns a list of strings representing a standard deck of
    playing cards.
  """
  @spec create_deck() :: [Card]
  def create_deck do
    for suit <- suits(), {type, value} <- types() do
      Card.new(type, suit, value)
    end
  end

  @doc """
    Returns a list of strings representing a standard deck of
    playing cards where the ordering of the cards has been
    randomized.
  """
  @spec shuffle([Card]) :: [Card]
  def shuffle(deck) do
    Enum.shuffle(deck)
  end

  @doc """
    Returns a boolean (true) value if the deck (lhs value)
    contains the given hand (rhs value).

  ## Examples

    iex> deck = Deck.create_deck()
    iex> deck = Deck.shuffle(deck)
    iex> card = Card.new("Ace", "Spades")
    iex> Deck.contains?(deck, Card.to_string(card)
    true
  """
  @spec contains?([Card.t()], Card.t()) :: boolean()
  def contains?(hand, card) do
    Enum.member?(hand, card)
  end

  @doc """
    Divides a deck into a hand and the remainder of the deck.
    The `hand_size` arguement indicates how many cards should
    be in the hand.

  ## Examples

      iex> deck = Cards.create_deck()
      iex> {hand, _deck} = Cards.deal(deck, 1)
      iex> hand
      ["Ace of Spades"]

  """
  @spec deal([Card], integer()) :: {[Card], [Card]}
  def deal(deck, hand_size) do
    Enum.split(deck, hand_size)
  end
end
