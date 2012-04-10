require 'snip'
require 'rainbow'

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

          first_line = ""
          File.open(Snip::INSTALL_DIR + '/' + file) {|f| first_line = f.readline}

          printf("%-35s # %s", file.color(:blue), first_line);
        end
      end
    end
  end
end
