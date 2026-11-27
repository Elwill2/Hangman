require "minitest/autorun"
require "stringio"
require "tmpdir"
require "fileutils"

require_relative "../lib/board"
require_relative "../lib/dictionary"
require_relative "../lib/game"
require_relative "../lib/save_file"

FIXTURES = File.expand_path("fixtures", __dir__)
