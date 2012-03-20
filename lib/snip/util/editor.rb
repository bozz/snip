
module Snip
  module Util
    class Editor
      def self.open(file_path)
        `vim "#{file_path}" 3>&1 1>&2 2>&3`
      end
    end
  end
end
