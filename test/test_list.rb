require 'helper'

class TestList < Test::Unit::TestCase
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

  def test_list_existing_snippets
    add_snippet(["snippet1", "first snippet"])
    add_snippet(["snippet2", "second snippet"])

    Snip::Snippet::list
    assert_match("snippet1", $stdout.string)
    assert_match("snippet2", $stdout.string)
  end

  def test_list_no_snippets
    Snip::Snippet::list
    assert_empty($stdout.string)
  end
end
