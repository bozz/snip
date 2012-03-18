require 'helper'

class TestInitialization < Test::Unit::TestCase
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
      Snip::Snippet::add("test_snippet", "test snippet")
    end
  end

  def test_uninitialized_show_call
    assert_raises Snip::NotInitializedError do
      Snip::Snippet::show("test_snippet")
    end
  end

  def test_uninitialized_list_call
    assert_raises Snip::NotInitializedError do
      Snip::Snippet::list
    end
  end

  def test_uninitialized_remove_call
    assert_raises Snip::NotInitializedError do
      Snip::Snippet::remove("test_snippet")
    end
  end
end
