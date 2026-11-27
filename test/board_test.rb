require_relative "test_helper"

class BoardTest < Minitest::Test
  def setup
    @board = Board.new("zipper")
  end

  def pick(*letters)
    letters.each { |letter| @board.pick_letter(letter) }
  end

  def test_a_new_board_hides_every_letter
    assert_equal "_ _ _ _ _ _", @board.word_line
  end

  def test_found_letters_show_in_every_place
    pick("p", "e")

    assert_equal "_ _ p p e _", @board.word_line
  end

  def test_a_new_board_has_all_guesses_left
    assert_equal Board::MAX_WRONG_GUESSES, @board.guesses_left
  end

  def test_a_wrong_letter_costs_one_guess
    pick("j")

    assert_equal 7, @board.guesses_left
  end

  def test_a_correct_letter_costs_nothing
    pick("p")

    assert_equal 8, @board.guesses_left
  end

  def test_the_same_wrong_letter_twice_costs_one_guess
    pick("a", "a")

    assert_equal 7, @board.guesses_left
  end

  def test_wrong_letters_lists_only_the_misses
    pick("a", "p", "b")

    assert_equal %w[a b], @board.wrong_letters
  end

  def test_tried_letters_keep_the_order_they_were_typed
    pick("a", "p")

    assert_equal "a p", @board.tried_letters
  end

  def test_letter_used
    pick("b")

    assert @board.letter_used?("b")
    refute @board.letter_used?("j")
  end

  def test_seven_wrong_letters_is_not_lost
    pick("a", "b", "c", "d", "f", "g", "h")

    refute @board.lost?
  end

  def test_eight_wrong_letters_is_lost
    pick("a", "b", "c", "d", "f", "g", "h", "j")

    assert @board.lost?
  end

  def test_some_letters_found_is_not_won
    pick("p", "e")

    refute @board.won?
  end

  def test_every_letter_found_is_won
    pick("z", "i", "p", "e", "r")

    assert @board.won?
  end
end
