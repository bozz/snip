require 'helper'

# Override Snip::Util::Editor::open for testing, replacing
# with alternative implementation that simply creates file
# without opening text editor.
module Snip
  module Util
    class Editor
      class << self
        include Snip::Commands
        def open(file_path)
          add_snippet(["test", "this is a test"])
        end
      end
    end
  end
end

class TestAdd < Test::Unit::TestCase
  include Snip::Commands
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
    Snip.init
  end

  def test_add_new_snippet
    add_snippet(["test", "this is a test"])
    assert_equal(true, File.exists?(File.join(Snip::INSTALL_DIR, 'test')))
  end

  def test_add_with_duplicate_name
    add_snippet(["test", "this is a test"])
    assert_raises Snip::DuplicateSnippetNameError do
      add_snippet(["test", "this is another test"])
    end
  end

  def test_add_with_one_arguments
    add_snippet(["test"])
    assert_equal(true, File.exists?(File.join(Snip::INSTALL_DIR, 'test')))
  end
end
