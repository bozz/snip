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

    list_snippets
    assert_match("snippet1", $stdout.string)
    assert_match("snippet2", $stdout.string)
  end

  def test_list_no_snippets
    list_snippets
    assert_empty($stdout.string)
  end

  def test_filtering_listed_snippets
    add_snippet(["aa_snippet", "first snippet"])
    add_snippet(["bb_snippet", "second snippet"])
    add_snippet(["cc_snippet", "third snippet"])

    list_snippets('bb')
    assert_match("bb_snippet", $stdout.string)
    refute_match("aa_snippet", $stdout.string)
    refute_match("cc_snippet", $stdout.string)
  end

  def test_show_first_line_of_snippet
    add_snippet(["aa_snippet", "first line\nsecond line"])

    list_snippets
    assert_match("first line", $stdout.string)
    refute_match("second line", $stdout.string)
  end
end
