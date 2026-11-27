# Talks to the player: shows the board, reads letters and runs the turns.
# Input and output are passed in, so tests can play a whole game with StringIO.
class Game
  SAVE_KEY = "0".freeze

  def initialize(board, save_file, input: $stdin, output: $stdout)
    @board = board
    @save_file = save_file
    @input = input
    @output = output
  end

  # Plays until the game is won or lost, the player saves, or the input ends.
  def play
    until @board.lost? || @board.won?
      show_board
      guess = ask_letter_until_valid
      return say_goodbye if guess.nil?
      return save_game if guess == SAVE_KEY

      take_guess(guess)
    end

    show_result
    @save_file.delete
  end

  def valid_letter?(guess)
    guess.match?(/\A[a-z]\z/)
  end

  private

  def show_board
    @output.puts
    @output.puts "Can you guess the secret word?"
    @output.puts @board.word_line
    @output.puts "Letters tried: #{@board.tried_letters}" unless @board.tried_letters.empty?
    @output.puts guesses_left_message
    @output.puts "Type #{SAVE_KEY} to save and quit."
  end

  def guesses_left_message
    count = @board.guesses_left
    "You have #{count} #{count == 1 ? 'guess' : 'guesses'} left."
  end

  # Returns a lowercase letter, SAVE_KEY, or nil when the input ends (Ctrl-D).
  def ask_letter_until_valid
    loop do
      @output.puts "Type a letter from A to Z:"
      line = @input.gets
      return nil if line.nil?

      guess = line.strip.downcase
      return guess if valid_letter?(guess) || guess == SAVE_KEY

      @output.puts "That's not a single letter."
    end
  end

  def take_guess(letter)
    if @board.letter_used?(letter)
      @output.puts "You already tried #{letter}. Pick another one."
    else
      @board.pick_letter(letter)
    end
  end

  def save_game
    @save_file.save(@board)
    @output.puts "Game saved. Type 1 next time to continue."
  end

  def say_goodbye
    @output.puts
    @output.puts "Goodbye!"
  end

  def show_result
    if @board.won?
      @output.puts "You found the secret word: #{@board.secret_word}!"
    else
      @output.puts "You ran out of guesses. The word was #{@board.secret_word}."
    end
  end
end
