require 'gli'
require 'snip'
include GLI


desc 'add new snippet'
command :add do |c|
  # c.desc 'add new snippet'
  # c.flag :m

  c.action do |global_options,options,arguments|
    a = arguments.first

    Snip::Command::Add.new(arguments, options).execute
  end
end


module Snip
  module Command
    class Add
      def initialize(args, options={})
        @args = args
        @options = options
      end

      def execute
        name, content = @args
        raise NotInitializedError unless Snip::initialized?
        raise DuplicateSnippetNameError if Snip::Snippet::exists?(name)

        file_path = File.join(Snip::INSTALL_DIR, name)
        if content.nil?
          raise ArgumentError
          # Snip::open_editor(file_path)
        else
          File.open(file_path, 'w') do |f|
            f.puts content
          end
        end
      end
    end
  end
end
