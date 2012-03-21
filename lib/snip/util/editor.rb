
module Snip
  module Util
    class Editor
      def self.open(file_path)
        unless ENV.has_key?('EDITOR')
          puts "No editor configured. The $EDITOR shell variable is empty."
          puts "Example: Add 'echo EDITOR=vim' to your .bashrc or .zshrc if you would like to use VIM as your editor."
          return
        end

        # open configured editor and redirect outputs
        `#{ENV['EDITOR']} "#{file_path}" 3>&1 1>&2 2>&3`

        if $?.success?
          if File.exists?(file_path)
            puts "Snippet created successfully"
          end
        else
          puts "Error occured: " + $?.to_s
        end
      end
    end
  end
end
