require 'snip'
require 'snip/util/editor'

module Snip
  module Command
    class Add
      include Snip

      def initialize(args, options={})
        @args = Array(args)
        @options = options
      end

      def execute
        name, content = @args
        raise NotInitializedError unless Snip::initialized?
        raise DuplicateSnippetNameError if Snip::snippet_exists?(name)

        file_path = File.join(Snip::INSTALL_DIR, name)
        if content.nil?
          if Snip::Util::Editor::open(file_path)
            if File.exists?(file_path)
              puts "Snippet created successfully"
            end
          end
        else
          File.open(file_path, 'w') do |f|
            f.puts content
          end
        end
      end
    end
  end
end
