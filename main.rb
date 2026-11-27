require_relative "lib/board"
require_relative "lib/dictionary"
require_relative "lib/game"
require_relative "lib/save_file"

save_file = SaveFile.new

answer = nil
until %w[1 2].include?(answer)
  puts "Type 1 to load your last saved game, or 2 to start a new one."
  line = $stdin.gets
  exit if line.nil?
  answer = line.strip
end

board = save_file.load if answer == "1"
puts "No saved game found. Starting a new one." if answer == "1" && board.nil?
board ||= Board.new(Dictionary.new.random_word)

Game.new(board, save_file).play
