require 'snip/command/list'
require 'snip/command/show'
require 'snip/command/add'
require 'snip/command/edit'
require 'snip/command/run'
require 'snip/command/remove'

module Snip
  module Commands
    def list_snippets(args=[], options={})
      Snip::Command::List.new(args, options).execute
    end

    def show_snippet(args, options={})
      Snip::Command::Show.new(args, options).execute
    end

    def add_snippet(args, options={})
      Snip::Command::Add.new(args, options).execute
    end

    def edit_snippet(args, options={})
      Snip::Command::Edit.new(args, options).execute
    end

    def run_snippet(args, options={})
      Snip::Command::Run.new(args, options).execute
    end

    def remove_snippet(args, options={})
      Snip::Command::Remove.new(args, options).execute
    end
  end
end
