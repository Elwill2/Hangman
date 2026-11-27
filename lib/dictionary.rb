# Loads a word list once and picks secret words of a playable length.
class Dictionary
  DEFAULT_PATH = File.expand_path("../google-10000-english-no-swears.txt", __dir__)
  MIN_LENGTH = 5
  MAX_LENGTH = 12

  def initialize(path = DEFAULT_PATH)
    @words = File.readlines(path, chomp: true).select do |word|
      word.length.between?(MIN_LENGTH, MAX_LENGTH)
    end
  end

  def random_word
    @words.sample
  end
end
