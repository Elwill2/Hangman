


class Dictionary 
  def random_word
    words = File.readlines("google-10000-english-no-swears.txt")
    clean_words = words.map { |word| 
    word.chomp}
    good_words = clean_words.select { |word| 
    word.length.between?(5, 12) }
    good_words.sample
  end 
end 


class Board
   attr_reader :secret_word

  def initialize(secret_word)
    @secret_word = secret_word
    @correct_letters = []
    @wrong_letters = []
    @allowed_guesses = 8
    @letters = []
  end

  def letter_used?(guessed_letter)
    @letters.include?(guessed_letter) 
  end

  def pick_letter(guessed_letter)
      return if letter_used?(guessed_letter)
    if @secret_word.include?(guessed_letter)
      @correct_letters << guessed_letter
    else
      @wrong_letters << guessed_letter
    end
    @letters << guessed_letter
  end

  def word_line
    @secret_word.chars.map { |secret_letter| 
    if @correct_letters.include?(secret_letter) then secret_letter else "_" end }.join(" ")
  end

  def guesses_left
    @allowed_guesses - @wrong_letters.length
  end

  def game_over? 
    guesses_left == 0 
  end

  def player_won?
    @secret_word.chars.all? { |letter| @correct_letters.include?(letter) }
  end

  def tried_letters
  @letters.join(" ")
  end

end


class Game 
  def initialize(board)
    @board = board
  end


  def ask_letter
    puts "Please type a letter from A to Z : "
    input = gets.chomp
    input.downcase
  end

  def valid_letter?(guess)
    ("a".."z").include?(guess) 
  end

  def ask_letter_until_valid
    guess = ask_letter
    until valid_letter?(guess)
    puts "That's not a single letter"
    guess = ask_letter
    end
    guess
  end

  def player_turn
    puts "Can you guess the secret word ?"
    puts @board.word_line
    unless @board.tried_letters.empty?
    puts "You've already tried these letters : "
    puts @board.tried_letters  
    end
    @board.guesses_left
    if @board.guesses_left == 1 
    puts "You have #{@board.guesses_left} guess left." 
    else @board.guesses_left
    puts "You have #{@board.guesses_left} guesses left."
    end
    guess = ask_letter_until_valid
    if @board.letter_used?(guess)
      puts "You've already played this letter. Pick another one."
    else @board.pick_letter(guess)
    end
  end

  def play_game
    until @board.game_over? || @board.player_won?
      player_turn
    end
      if @board.game_over?
        puts "You haven't found the correct word within the given try. The word was #{@board.secret_word}."
      else 
        puts "You have found the secret word : #{@board.secret_word}."
      end
  end
end