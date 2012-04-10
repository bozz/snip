require 'snip'

module Snip
  module Command
    class List
      def initialize(args=[], options={})
        @args = Array(args)
        @options = options
      end

      def execute
        raise NotInitializedError unless Snip::initialized?

        Dir.foreach(Snip::INSTALL_DIR) do |file|
          next if file == '.' or file == '..'
          next unless @args.empty? || file.match(@args.first)
          puts "#{file}"
        end
      end
    end
  end
end
