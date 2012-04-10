require 'snip'

module Snip
  module Command
    class Show
      def initialize(args, options={})
        @args = Array(args)
        @options = options
      end

      def execute
        name = @args
        raise NotInitializedError unless Snip::initialized?
        raise SnippetNotFoundError unless Snip::snippet_exists?(name)

        puts File.read(File.join(Snip::INSTALL_DIR, name)).color(:magenta)
      end
    end
  end
end
