# Keeps the state of one game and answers questions about it.
# It never prints or reads anything, which makes it easy to test.
class Board
  MAX_WRONG_GUESSES = 8

  attr_reader :secret_word

  def initialize(secret_word)
    @secret_word = secret_word
    @letters = []
  end

  def letter_used?(letter)
    @letters.include?(letter)
  end

  def pick_letter(letter)
    @letters << letter unless letter_used?(letter)
  end

  def wrong_letters
    @letters.reject { |letter| @secret_word.include?(letter) }
  end

  def word_line
    @secret_word.chars.map { |letter| letter_used?(letter) ? letter : "_" }.join(" ")
  end

  def tried_letters
    @letters.join(" ")
  end

  def guesses_left
    MAX_WRONG_GUESSES - wrong_letters.length
  end

  def lost?
    guesses_left <= 0
  end

  def won?
    @secret_word.chars.all? { |letter| letter_used?(letter) }
  end
end
