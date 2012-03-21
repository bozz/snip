require 'helper'

class TestRun < Test::Unit::TestCase
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

  def test_run_existing_snippet
    hostname = `hostname -s`
    add_snippet(["test_snippet", "hostname -s"])

    run_snippet(["test_snippet"])
    assert_match(hostname, $stdout.string)
  end

  def test_run_invalid_command
    add_snippet(["test_snippet", "nonexisting_command"])

    assert_raises Snip::ExecuteSnippetError do
      run_snippet(["test_snippet"])
    end
  end

  def test_run_nonexisting_snippet
    assert_raises Snip::SnippetNotFoundError do
      run_snippet(["nonexisting_snippet"])
    end
  end
end
