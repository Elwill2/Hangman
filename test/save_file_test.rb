require_relative "test_helper"

class SaveFileTest < Minitest::Test
  def setup
    @dir = Dir.mktmpdir
    @path = File.join(@dir, "save.yaml")
    @save_file = SaveFile.new(@path)
  end

  def teardown
    FileUtils.remove_entry(@dir)
  end

  def test_load_without_a_save_returns_nil
    assert_nil @save_file.load
  end

  def test_a_saved_board_loads_back_the_same
    board = Board.new("zipper")
    board.pick_letter("p")
    board.pick_letter("a")

    @save_file.save(board)
    loaded = @save_file.load

    assert_equal "zipper", loaded.secret_word
    assert_equal "p a", loaded.tried_letters
    assert_equal 7, loaded.guesses_left
  end

  def test_delete_removes_the_save
    @save_file.save(Board.new("zipper"))
    @save_file.delete

    refute @save_file.exist?
  end

  def test_delete_without_a_save_does_nothing
    @save_file.delete

    refute @save_file.exist?
  end

  def test_refuses_to_load_anything_but_a_board
    File.write(@path, "--- !ruby/object:Object {}\n")

    assert_raises(Psych::DisallowedClass) { @save_file.load }
  end
end
