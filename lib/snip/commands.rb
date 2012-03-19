require 'snip/command/add'

module Snip
  module Commands
    def add_snippet(args, options={})
      Snip::Command::Add.new(args, options).execute
    end
  end
end
