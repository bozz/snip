require 'helper'

class TestRemove < Test::Unit::TestCase
  include Snip::Commands
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
    Snip.init

    # redirect stdout to StringIO for testing
    $stdout = StringIO.new
  end

  def test_remove_existing_snippet
    add_snippet(["snippet1", "first snippet"])

    Snip::Snippet::remove(["snippet1"])
    assert_equal(false, Snip::Snippet::exists?("snippet1"))
  end

  def test_remove_nonexisting_snippet
    assert_raises Snip::SnippetNotFoundError do
      Snip::Snippet::remove(["nonexisting_snippet"])
    end
  end
end
