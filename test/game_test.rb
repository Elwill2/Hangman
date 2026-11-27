require_relative "test_helper"

# These tests play whole games: StringIO stands in for the keyboard and the screen.
class GameTest < Minitest::Test
  def setup
    @dir = Dir.mktmpdir
    @save_file = SaveFile.new(File.join(@dir, "save.yaml"))
    @board = Board.new("zipper")
  end

  def teardown
    FileUtils.remove_entry(@dir)
  end

  # Types each line, then ends the input, and returns everything printed.
  def play(*lines)
    output = StringIO.new
    input = StringIO.new(lines.map { |line| "#{line}\n" }.join)
    Game.new(@board, @save_file, input: input, output: output).play
    output.string
  end

  def test_finding_every_letter_wins
    output = play("z", "i", "p", "e", "r")

    assert_includes output, "You found the secret word: zipper!"
  end

  def test_eight_wrong_letters_loses
    output = play("a", "b", "c", "d", "f", "g", "h", "j")

    assert_includes output, "You ran out of guesses. The word was zipper."
  end

  def test_upper_case_letters_count
    output = play("Z", "I", "P", "E", "R")

    assert_includes output, "You found the secret word: zipper!"
  end

  def test_anything_but_one_letter_is_asked_again
    output = play("ab", "7", "", "z")

    assert_equal 3, output.scan("That's not a single letter.").size
    assert @board.letter_used?("z")
  end

  def test_a_letter_tried_twice_is_refused_and_costs_nothing
    output = play("a", "a")

    assert_includes output, "You already tried a. Pick another one."
    assert_equal 7, @board.guesses_left
  end

  def test_one_guess_left_is_singular
    output = play("a", "b", "c", "d", "f", "g", "h")

    assert_includes output, "You have 1 guess left."
  end

  def test_typing_0_saves_and_stops
    output = play("p", Game::SAVE_KEY, "z")

    assert_includes output, "Game saved."
    assert_equal "p", @save_file.load.tried_letters
  end

  def test_the_save_is_deleted_when_the_game_ends
    @save_file.save(@board)
    play("z", "i", "p", "e", "r")

    refute @save_file.exist?
  end

  def test_the_end_of_input_quits_without_crashing
    output = play

    assert_includes output, "Goodbye!"
  end

  def test_valid_letter
    game = Game.new(@board, @save_file)

    assert game.valid_letter?("a")
    assert game.valid_letter?("z")
    refute game.valid_letter?("ab")
    refute game.valid_letter?("7")
    refute game.valid_letter?("")
  end
end
