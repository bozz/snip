require 'snip'
require 'snip/util/editor'

module Snip
  module Command
    class Edit
      include Snip

      def initialize(args, options={})
        @args = Array(args)
        @options = options
      end

      def execute
        name = @args
        raise NotInitializedError unless Snip::initialized?
        raise SnippetNotFoundError unless Snip::snippet_exists?(name)

        file_path = File.join(Snip::INSTALL_DIR, name)
        if Snip::Util::Editor::open(file_path)
          puts "Snippet updated successfully"
        end
      end
    end
  end
end
