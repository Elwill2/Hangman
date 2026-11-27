require "yaml"
require_relative "board"

# Saves a Board to a YAML file and loads it back.
class SaveFile
  DEFAULT_PATH = File.expand_path("../hangman_save.yaml", __dir__)

  def initialize(path = DEFAULT_PATH)
    @path = path
  end

  def exist?
    File.exist?(@path)
  end

  def save(board)
    File.write(@path, board.to_yaml)
  end

  # Returns the saved Board, or nil when there is no saved game.
  # Only a Board may come out of the file, so an edited file can't create other objects.
  def load
    return nil unless exist?

    YAML.safe_load_file(@path, permitted_classes: [Board])
  end

  def delete
    File.delete(@path) if exist?
  end
end
