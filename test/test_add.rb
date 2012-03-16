require 'helper'

class TestAdd < Test::Unit::TestCase
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
    Snip.init
  end

  def test_add_new_snippet
    Snip::Snippet::add("test", "this is a test")
    assert_equal(true, File.exists?(File.join(Snip::INSTALL_DIR, 'test')))
  end

  def test_add_with_duplicate_name
    Snip::Snippet::add("test", "this is a test")
    assert_raises Snip::DuplicateSnippetNameError do
      Snip::Snippet::add("test", "this is another test")
    end
  end

  def test_add_with_wrong_number_of_arguments
    assert_raises ArgumentError do
      Snip::Snippet::add("test")
    end
  end
end
