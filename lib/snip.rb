module Snip

  INSTALL_DIR = '~/.snip'

  class NotInitializedError < StandardError ; end
  class DuplicateSnippetNameError < StandardError ; end

  def self.initialized?
    File.directory?(Snip::INSTALL_DIR)
  end

  def self.init
    unless Snip::initialized?
      FileUtils.mkdir(Snip::INSTALL_DIR)
    end
  end

  class Snippet
    def self.exists?(name)
      File.exists?(File.join(Snip::INSTALL_DIR, name))
    end

    def self.add(name, content)
      raise NotInitializedError unless Snip::initialized?
      raise DuplicateSnippetNameError if Snip::Snippet::exists?(name)

      file = File.new(File.join(Snip::INSTALL_DIR, name),'w')
      file.write(content)
      file.close
    end

    def self.show(name)
      puts "test snippet"
    end
  end
end
