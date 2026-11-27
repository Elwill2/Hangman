# Hangman

A command-line Hangman game in Ruby, built for the [Ruby Hangman project](https://www.theodinproject.com/lessons/ruby-hangman) of The Odin Project.

The computer picks a secret word between 5 and 12 letters from a dictionary of common English words. You guess it one letter at a time, with up to 8 wrong guesses allowed.

## How to play

Run:

```
ruby main.rb
```

This works from any folder, for example `ruby Hangman/main.rb`.

At the start, the game asks whether to load your last saved game or start a new one:

- type `1` to load the last saved game (if there is no save, the game says so and starts a new one)
- type `2` to start a new game

Any other answer is asked again.

Each turn shows:

- the word, with the letters you found in place: `_ a _ _ _ _ e _ _ a`
- the letters you already tried, in the order you typed them
- how many wrong guesses you have left

Type one letter and press Enter. Upper or lower case both work. A correct letter costs nothing, a wrong one costs a guess, and a letter you already tried is refused.

You win when every letter of the word is found. You lose when you run out of wrong guesses, and the game tells you the word.

Press Ctrl-D to quit without saving.

## Saving

At the start of any turn, type `0` instead of a letter. The game is saved to `hangman_save.yaml` and the program stops. Next time, type `1` when the game starts to continue exactly where you stopped.

The save file is deleted when a game ends, so a finished game can't be loaded again. It is listed in `.gitignore`, so it never gets committed.

## Tests

The tests use [Minitest](https://github.com/minitest/minitest) and run with Rake. Both come with Ruby.

```
rake test
```

Run a single test file with:

```
ruby test/board_test.rb
```

There is one test file per class. `test/game_test.rb` plays whole games by passing a `StringIO` in place of the keyboard and the screen, so nobody has to type.

## Style

```
rubocop
```

checks the style, and `rubocop -a` fixes what it can. The settings are in `.rubocop.yml`.

## Files

- `main.rb`: starts the program and offers to load a saved game
- `lib/`: one class per file
  - `dictionary.rb`: `Dictionary` loads the word list once and picks a random word of 5 to 12 letters
  - `board.rb`: `Board` keeps the state of one game (secret word, letters tried) and answers questions about it. It never prints or reads anything
  - `game.rb`: `Game` talks to the player: shows the board, asks for letters and runs the turns
  - `save_file.rb`: `SaveFile` saves a board to YAML, loads it back and deletes it
- `test/`: one `_test.rb` file per class, plus `test_helper.rb` and a small word list in `fixtures/`
- `Rakefile`: the `rake test` task
- `google-10000-english-no-swears.txt`: the dictionary, from the [first20hours google-10000-english](https://github.com/first20hours/google-10000-english) repository
