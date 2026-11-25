require_relative "hangman"


def check(label, actual, expected)
  if actual == expected
    puts "OK   #{label}"
  else
    puts "FAIL #{label}"
    puts "  expected #{expected.inspect}, got #{actual.inspect}"
  end
end

words = Array.new(100) { Dictionary.new.random_word }
check("random_word gives 5 to 12 letter", words.all?  { |word| word.length.between?(5, 12) }, true)




board = Board.new("zipper")
board.pick_letter("p")
board.pick_letter("e")
check("p and e show", board.word_line, "_ _ p p e _")
board = Board.new("zipper")
board.pick_letter("j")
check("one wrong letter leaves 7 guesses", board.guesses_left, 7)
board = Board.new("zipper")
["a", "b", "c", "d", "f", "g", "h"].each { |letter| board.pick_letter(letter) }
check("7 wrong letters: not over", board.game_over?, false)
board.pick_letter("j")
check("8 wrong letters: over", board.game_over?, true)
board = Board.new("zipper")
board.pick_letter("p")
board.pick_letter("e")
check("only p and e: not won", board.player_won?, false)
["z", "i", "r"].each { |letter| board.pick_letter(letter) }
check("all letters found: won", board.player_won?, true)
board = Board.new("zipper")
board.pick_letter("a") 
board.pick_letter("a")
check("7 guesses left", board.guesses_left, 7)
board = Board.new("zipper")
board.pick_letter("p")
board.pick_letter("p")
check("8 guesses left", board.guesses_left, 8)
board = Board.new("zipper")
board.pick_letter("b")
check("b used: true", board.letter_used?("b"), true)
board = Board.new("zipper")
board.pick_letter("c")
check("j not used:false", board.letter_used?("j"), false)
game = Game.new(Board.new("zipper"))
check("a is valid", game.valid_letter?("a"), true)
check("ab is not valid", game.valid_letter?("ab"), false)
check("z is valid", game.valid_letter?("z"), true)
check("7 is not valid", game.valid_letter?("7"), false)
check(""" is not valid", game.valid_letter?(""""), false)
board = Board.new("zipper")
board.pick_letter("a")
board.pick_letter("b")
check("a b as used letters", board.tried_letters, "a b")
board = Board.new("zipper")
board.pick_letter("a")
board.pick_letter("p")
check("a p as used letters", board.tried_letters, "a p")