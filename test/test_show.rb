require 'helper'

class TestShow < Test::Unit::TestCase
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

  def test_show_existing_snippet
    @snippet_text = "this is a test: #{Time.now.to_s}"
    add_snippet(["test_snippet", @snippet_text])

    show_snippet(["test_snippet"])
    assert_match(@snippet_text, $stdout.string)
  end

  def test_show_nonexisting_snippet
    assert_raises Snip::SnippetNotFoundError do
      show_snippet(["nonexisting_snippet"])
    end
  end
end
