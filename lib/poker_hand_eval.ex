defmodule PokerHandEval do
  @moduledoc """
  Documentation for `PokerHandEval`.
  """
  alias PokerHandEval.Deck, as: Deck
  alias PokerHandEval.Card, as: Card

  def hand_eval() do
    deck = Deck.create_deck()
    shuffle_deck = Deck.shuffle(deck)
    {_deck, hand} = Deck.deal(shuffle_deck, 5)

    cond do
      is_royal_flush?(hand) ->
        "The hand provided is a royal flush!"

      is_straight_flush?(hand) ->
        "The hand provided is a straight flush!"

      is_flush?(hand) ->
        "The hand provided is a flush!"

      is_four_of_a_kind?(hand) ->
        "The hand provided is a four of a kind!"

      is_full_house?(hand) ->
        "The hand provided is a full house!"

      is_three_of_a_kind?(hand) ->
        "The hand provided is a three of a kind!"

      is_two_pair?(hand) ->
        "The hand provided is a two pair!"

      is_pair?(hand) ->
        "The hand provided is a pair!"

      is_high_card?(hand) ->
        "The hand provided is a high card!"
    end
  end

  @doc """
    Checks if provided hand is a royal flush.
  """
  @spec is_royal_flush?([Card]) :: boolean()
  def is_royal_flush?(hand) do
    is_straight_flush?(hand) and Enum.sum_by(hand, &Card.get_value/1) == 60
  end

  @doc """
    Checks if provided hand is a straight flush
  """
  @spec is_straight_flush?([Card]) :: boolean()
  def is_straight_flush?(hand) do
    is_straight?(hand) and is_flush?(hand)
  end

  @doc """
    Checks if provided hand is a straight
  """
  @spec is_straight?([Card]) :: boolean()
  def is_straight?(hand) do
    case Enum.member?(Enum.map(hand, fn card -> Card.get_type(card) end), :Ace) do
      true ->
        hand_value = Enum.sum_by(hand, &Card.get_value/1)
        hand_value == 60 or hand_value == 28

      false ->
        hand |> card_numbers() |> is_straight_helper()
    end
  end

  defp is_straight_helper(hand) do
    cond do
      length(hand) == 1 -> true
      hd(tl(hand)) - hd(hand) == 1 -> is_straight_helper(tl(hand))
      true -> false
    end
  end

  @doc """
    Checks if provided hand is a flush
  """
  @spec is_flush?([Card]) :: boolean()
  def is_flush?(hand) do
    hand
    |> Enum.map(&Card.get_suit/1)
    |> Enum.uniq()
    |> length() == 1
  end

  @doc """
    Checks if provided hand is a four of a kind
  """
  @spec is_four_of_a_kind?([Card]) :: boolean()
  def is_four_of_a_kind?(hand) do
    hand
    |> type_frequencies()
    |> Enum.max() == 4
  end

  @doc """
    Checks if provided hand is a full house
  """
  @spec is_full_house?([Card]) :: boolean()
  def is_full_house?(hand) do
    hand
    |> type_frequencies == [2, 3]
  end

  @doc """
    Checks if provided hand is a three of a kind
  """
  @spec is_three_of_a_kind?([Card]) :: boolean()
  def is_three_of_a_kind?(hand) do
    hand
    |> type_frequencies() == [1, 1, 3]
  end

  @doc """
    Checks if provided hand is a two pair
  """
  @spec is_two_pair?([Card]) :: boolean()
  def is_two_pair?(hand) do
    hand
    |> type_frequencies() == [1, 2, 2]
  end

  @doc """
    Checks if provided hand is a pair
  """
  @spec is_pair?([Card]) :: boolean()
  def is_pair?(hand) do
    hand
    |> type_frequencies() == [1, 1, 1, 2]
  end

  @doc """
    Checks if provided hand is a high card
  """
  @spec is_high_card?([Card]) :: boolean()
  def is_high_card?(hand) do
    hand
    |> type_frequencies() == [1, 1, 1, 1, 1]
  end

  @spec type_frequencies([Card]) :: list(integer())
  defp type_frequencies(hand) do
    hand
    |> Enum.map(&Card.get_type/1)
    |> Enum.frequencies()
    |> Map.values()
    |> Enum.sort()
  end

  @spec card_numbers([Card]) :: list(integer())
  defp card_numbers(hand) do
    hand
    |> Enum.map(&Card.get_value/1)
    |> Enum.sort()
  end
end
