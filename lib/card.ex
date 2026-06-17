defmodule PokerHandEval.Card do
  @moduledoc """
    Provides methods for creating and handling a playing card.
  """
  alias PokerHandEval.Card, as: Card

  @doc """
    Struct to manage the values that a card would have.
  """
  defstruct type: nil, suit: nil, value: nil

  @type t :: %__MODULE__{
          type: String.t() | nil,
          suit: String.t() | nil,
          value: Integer | nil
        }

  @type t(type, suit, value) :: %Card{type: type, suit: suit, value: value}

  @doc """
    Returns a new Card


    ### Examples

    iex> card = Card.new("Ace", "Spades")
    %Card{value: "Ace", suit: "Spades"}
  """
  @spec new(String.t(), String.t(), Integer) :: term()
  def new(type, suit, value) do
    %PokerHandEval.Card{
      type: type,
      suit: suit,
      value: value
    }
  end

  @doc """
    Returns the attributes of a Card in a formatted string

    ### Example
    
    iex> card = Card.new(:Ace, :Spades, 14)
    iex> Card.to_string(card)
    "Ace of Spades"
  """
  @spec to_string(PokerHandEval.Card.t()) :: String.t()
  def to_string(card) when card.value.title != nil and card.suit != nil do
    "#{Atom.to_string(card.type)} of #{Atom.to_string(card.suit)}"
  end

  @doc """
    Returns the value of a Card

    ### Example

    iex> card = Card.new(:Ace, :Spades, 14)
    iex> Card.get_type(card)
    :Ace  
  """
  @spec get_type(PokerHandEval.Card.t()) :: atom()
  def get_type(card) when card.type != nil do
    card.type
  end

  @doc """
    Returns the suit of a Card

    ### Example

    iex> card = Card.new("Ace", "Spades")
    iex> Card.get_suit(card)
    :Spades  
  """
  @spec get_suit(PokerHandEval.Card.t()) :: atom()
  def get_suit(card) when card.suit != nil do
    card.suit
  end

  @doc """
    Returns the value of a Card

    ### Example

    iex> card = Card.new("Ace", "Spades")
    iex> Card.get_value(card)
    14  
  """
  @spec get_value(PokerHandEval.Card.t()) :: integer()
  def get_value(card) when card.value != nil do
    card.value
  end
end
