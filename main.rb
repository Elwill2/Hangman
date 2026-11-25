require_relative "hangman"

word = Dictionary.new.random_word
board = Board.new(word)
game = Game.new(board)
game.play_game