require_relative "hangman"

puts "Do you want to load the last save game or play a new one ? Type 1 to load the last game or 2 for a new one."
answer = gets.chomp
if answer == "1" && File.exist?("hangman_save.yaml")
  board = YAML.load(File.read("hangman_save.yaml"), permitted_classes: [Board])
else 
  word = Dictionary.new.random_word 
  board = Board.new(word) 
end
game = Game.new(board)
game.play_game