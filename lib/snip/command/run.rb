require 'snip'

module Snip
  module Command
    class Run
      def initialize(args, options={})
        @args = Array(args)
        @options = options
      end

      def execute
        name = @args
        raise NotInitializedError unless Snip::initialized?
        raise SnippetNotFoundError unless Snip::snippet_exists?(name)

        snippet = File.read(File.join(Snip::INSTALL_DIR, name))

        begin
          puts snippet.color(:magenta)
          puts `#{snippet}`
        rescue
          raise ExecuteSnippetError
        end
      end
    end
  end
end
