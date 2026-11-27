require_relative "test_helper"

class DictionaryTest < Minitest::Test
  def test_picks_only_words_of_5_to_12_letters
    dictionary = Dictionary.new(File.join(FIXTURES, "words.txt"))
    words = Array.new(50) { dictionary.random_word }

    assert_equal %w[puzzle zipper], words.uniq.sort
  end

  def test_the_real_word_list_gives_playable_words
    dictionary = Dictionary.new
    words = Array.new(100) { dictionary.random_word }

    assert(words.all? { |word| word.length.between?(5, 12) })
  end

  def test_finds_the_word_list_from_another_folder
    word = Dir.chdir(Dir.tmpdir) { Dictionary.new.random_word }

    refute_nil word
  end
end
