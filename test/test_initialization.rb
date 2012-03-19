require 'helper'

class TestInitialization < Test::Unit::TestCase
  include Snip::Commands
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
  end

  def test_unintialized
    assert_equal(false, Snip::initialized?)
  end

  def test_intialized
    Snip.init
    assert_equal(true, Snip::initialized?)
  end

  def test_initialization
    Snip.init
    assert_equal(true, File.directory?(Snip::INSTALL_DIR))
  end

  def test_multiple_initializations
    Snip.init
    Snip.init
    assert_equal(true, File.directory?(Snip::INSTALL_DIR))
  end

  def test_uninitialized_add_call
    assert_raises Snip::NotInitializedError do
      add_snippet(["test", "this is a test"])
    end
  end

  def test_uninitialized_show_call
    assert_raises Snip::NotInitializedError do
      show_snippet(["test_snippet"])
    end
  end

  def test_uninitialized_list_call
    assert_raises Snip::NotInitializedError do
      list_snippets
    end
  end

  def test_uninitialized_remove_call
    assert_raises Snip::NotInitializedError do
      remove_snippet(["test_snippet"])
    end
  end
end
