require 'snip'

module Snip
  module Command
    class Remove
      def initialize(args, options={})
        @args = args
        @options = options
      end

      def execute
        name = @args
        raise NotInitializedError unless Snip::initialized?
        raise SnippetNotFoundError unless Snip::snippet_exists?(name)

        FileUtils.rm(File.join(Snip::INSTALL_DIR, name)) if Snip::snippet_exists?(name)
      end
    end
  end
end
