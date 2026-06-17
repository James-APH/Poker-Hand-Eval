defmodule PokerHandEvalTest do
  use ExUnit.Case
  doctest PokerHandEval

  defp card(type, suit, value) do
    PokerHandEval.Card.new(type, suit, value)
  end

  #
  # is_royal_flush? tests
  #
  test "is_royal_flush? returns true on a valid royal flush" do
    hand = [
      card(:Ace, :Spades, 14),
      card(:King, :Spades, 13),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Ten, :Spades, 10)
    ]

    assert PokerHandEval.is_royal_flush?(hand)
  end

  test "is_royal_flush? returns false on a invalid royal flush with mixed types" do
    hand = [
      card(:King, :Hearts, 13),
      card(:King, :Spades, 13),
      card(:Queen, :Spades, 12),
      card(:Three, :Diamonds, 11),
      card(:Ten, :Spades, 10)
    ]

    refute PokerHandEval.is_royal_flush?(hand)
  end

  #
  # is_straight_flush? tests
  #
  test "is_straight_flush? returns true on a valid straight flush" do
    hand = [
      card(:Ten, :Hearts, 10),
      card(:Nine, :Hearts, 9),
      card(:Eight, :Hearts, 8),
      card(:Seven, :Hearts, 7),
      card(:Six, :Hearts, 6)
    ]

    assert PokerHandEval.is_straight_flush?(hand)
  end

  test "is_straight_flush? returns false on a invalid straight with mixed suits" do
    hand = [
      card(:Ten, :Spades, 10),
      card(:Nine, :Hearts, 9),
      card(:Eight, :Hearts, 8),
      card(:Seven, :Hearts, 7),
      card(:Six, :Hearts, 6)
    ]

    refute PokerHandEval.is_straight_flush?(hand)
  end

  test "is_straight_flush? returns false on a invalid straight with mixed types" do
    hand = [
      card(:Ten, :Spades, 10),
      card(:Ten, :Hearts, 10),
      card(:Eight, :Hearts, 8),
      card(:Seven, :Hearts, 7),
      card(:Six, :Hearts, 6)
    ]

    refute PokerHandEval.is_straight_flush?(hand)
  end

  #
  # is_straight? tests
  #
  test "is_straight? returns true on valid straight" do
    hand = [
      card(:Ten, :Spades, 10),
      card(:Nine, :Hearts, 9),
      card(:Eight, :Hearts, 8),
      card(:Seven, :Hearts, 7),
      card(:Six, :Hearts, 6)
    ]

    assert PokerHandEval.is_straight?(hand)
  end

  test "is_straight? returns true on valid straight with high ace" do
    hand = [
      card(:Ace, :Spades, 14),
      card(:King, :Spades, 13),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Ten, :Spades, 10)
    ]

    assert PokerHandEval.is_straight?(hand)
  end

  test "is_straight? returns true on valid straight with low ace" do
    hand = [
      card(:Five, :Spades, 5),
      card(:Four, :Hearts, 4),
      card(:Three, :Hearts, 3),
      card(:Two, :Hearts, 2),
      card(:Ace, :Hearts, 14)
    ]

    assert PokerHandEval.is_straight?(hand)
  end

  test "is_straight? returns false on invalid straight with invalid types" do
    hand = [
      card(:Ten, :Spades, 10),
      card(:Ten, :Hearts, 10),
      card(:Eight, :Hearts, 8),
      card(:Two, :Hearts, 2),
      card(:Six, :Hearts, 6)
    ]

    refute PokerHandEval.is_straight?(hand)
  end

  test "is_straight? returns false on invalid straight with an ace and invalid types" do
    hand = [
      card(:Ace, :Spades, 14),
      card(:Ace, :Hearts, 14),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Two, :Spades, 2)
    ]

    refute PokerHandEval.is_straight?(hand)
  end

  #
  # is_flush? tests
  #
  test "is_flush? returns true on a valid flush" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Spades, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Spades, 3)
    ]

    assert PokerHandEval.is_flush?(hand)
  end

  test "is_flush? returns false on a invalid flush" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_flush?(hand)
  end

  #
  # is_four_of_a_kind? tests
  #
  test "is_four_of_a_kind? returns true on valid four of a kind" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Nine, :Clubs, 9),
      card(:Nine, :Diamonds, 9),
      card(:Three, :Spades, 3)
    ]

    assert PokerHandEval.is_four_of_a_kind?(hand)
  end

  test "is_four_of_a_kind? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_four_of_a_kind?(hand)
  end

  #
  # is_full_house? tests
  #
  test "is_full_house? returns true on valid full house" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Nine, :Clubs, 9),
      card(:Eight, :Diamonds, 8),
      card(:Eight, :Spades, 8)
    ]

    assert PokerHandEval.is_full_house?(hand)
  end

  test "is_full_house? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_full_house?(hand)
  end

  #
  # is_three_of_a_kind? tests
  #
  test "is_three_of_a_kind? returns true on valid three of a kind" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Nine, :Clubs, 9),
      card(:Seven, :Diamonds, 7),
      card(:Eight, :Spades, 8)
    ]

    assert PokerHandEval.is_three_of_a_kind?(hand)
  end

  test "is_three_of_a_kind?? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_three_of_a_kind?(hand)
  end

  #
  # is_two_pair? tests
  #
  test "is_two_pair? returns true on valid two pair" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Eight, :Clubs, 8),
      card(:Seven, :Diamonds, 7),
      card(:Eight, :Spades, 8)
    ]

    assert PokerHandEval.is_two_pair?(hand)
  end

  test "is_two_pair? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_two_pair?(hand)
  end

  #
  # is_pair? tests
  #
  test "is_pair? returns true on valid pair" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Five, :Clubs, 5),
      card(:Seven, :Diamonds, 7),
      card(:Eight, :Spades, 8)
    ]

    assert PokerHandEval.is_pair?(hand)
  end

  test "is_pair? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    refute PokerHandEval.is_pair?(hand)
  end

  #
  # is_high_card? tests
  #
  test "is_high_card? returns true on valid high card" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Two, :Hearts, 2),
      card(:Queen, :Spades, 12),
      card(:Jack, :Spades, 11),
      card(:Three, :Clubs, 3)
    ]

    assert PokerHandEval.is_high_card?(hand)
  end

  test "is_high_card? returns false on invalid hand" do
    hand = [
      card(:Nine, :Spades, 9),
      card(:Nine, :Hearts, 9),
      card(:Five, :Clubs, 5),
      card(:Seven, :Diamonds, 7),
      card(:Eight, :Spades, 8)
    ]

    refute PokerHandEval.is_high_card?(hand)
  end
end
