require 'helper'

class TestShow < Test::Unit::TestCase
  include FakeFS

  def setup
    FileSystem.clear
    # create home dir
    FileUtils.mkdir_p(File.expand_path('~'))
    Snip.init
    Snip::Snippet::add("test", "test snippet")

    sio = StringIO.new
    old_stdout, $stdout = $stdout, sio
  end

  def test_show_existing_snippet
    Snip::Snippet::show("test")
    assert_match("test snippet", $stdout.string)
  end
end
