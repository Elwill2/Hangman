Hangman

A command-line Hangman game in Ruby, built for the Ruby Hangman project of The Odin Project.

The computer picks a secret word between 5 and 12 letters from a dictionary of common English words. You guess it one letter at a time, with up to 8 wrong guesses allowed.

How to play

From the project folder, run:

ruby main.rb

At the start, the game asks whether to load your last saved game or start a new one:

type 1 to load the last saved game (if there is no save, a new game starts)
type 2 to start a new game

Each turn shows:

the word, with the letters you found in place: _ a _ _ _ _ e _ _ a
the letters you already tried, in the order you typed them
how many wrong guesses you have left

Type one letter and press Enter. Upper or lower case both work. A correct letter costs nothing, a wrong one costs a guess, and a letter you already tried is refused.

You win when every letter of the word is found. You lose when you run out of wrong guesses, and the game tells you the word.

Saving

At the start of any turn, type 0 instead of a letter. The game is saved to hangman_save.yaml and the program stops. Next time, type 1 when the game starts to continue exactly where you stopped.

The save file is deleted when a game ends, so a finished game can't be loaded again.

Tests

The game logic is checked by a small test file:

ruby hangman_test.rb

Each line prints OK or FAIL, with the expected and actual values when a check fails.

Files
hangman.rb: the three classes
Dictionary loads the word list and picks a random word of 5 to 12 letters
Board keeps the state of the game (secret word, letters tried, guesses left) and answers questions about it
Game talks to the player: shows the board, asks for letters, saves, and runs the turns
main.rb: starts the program and offers to load a saved game
hangman_test.rb: the checks
google-10000-english-no-swears.txt: the dictionary, from the first20hours google-10000-english repository
