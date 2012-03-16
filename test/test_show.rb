require 'helper'

class TestShow < Test::Unit::TestCase
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
    Snip.init
  end

  def test_show_existing_snippet
    @snippet_text = "this is a test: #{Time.now.to_s}"
    Snip::Snippet::add("test_snippet", @snippet_text)

    Snip::Snippet::show("test_snippet")
    assert_match(@snippet_text, $stdout.string)
  end

  def test_show_nonexisting_snippet
    assert_raises Snip::SnippetNotFoundError do
      Snip::Snippet::show("nonexisting_snippet")
    end
  end
end
