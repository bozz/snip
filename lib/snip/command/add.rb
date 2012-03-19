require 'snip'

module Snip
  module Command
    class Add
      include Snip

      def initialize(args, options={})
        @args = args
        @options = options
      end

      def execute
        name, content = @args
        raise NotInitializedError unless Snip::initialized?
        raise DuplicateSnippetNameError if Snip::snippet_exists?(name)

        file_path = File.join(Snip::INSTALL_DIR, name)
        if content.nil?
          Snip::open_editor(file_path)
        else
          File.open(file_path, 'w') do |f|
            f.puts content
          end
        end
      end
    end
  end
end
