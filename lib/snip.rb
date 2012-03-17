module Snip

  INSTALL_DIR = '~/.snip'

  class NotInitializedError < StandardError ; end
  class DuplicateSnippetNameError < StandardError ; end
  class SnippetNotFoundError < StandardError ; end

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
      raise NotInitializedError unless Snip::initialized?
      raise SnippetNotFoundError unless Snip::Snippet::exists?(name)

      puts File.read(File.join(Snip::INSTALL_DIR, name))
    end

    def self.list
      raise NotInitializedError unless Snip::initialized?

      Dir.foreach(Snip::INSTALL_DIR) do |file|
        puts file if File.file?(file)
      end
    end

    def self.remove(name)
      raise SnippetNotFoundError unless Snip::Snippet::exists?(name)

      FileUtils.rm(File.join(Snip::INSTALL_DIR, name)) if Snip::Snippet::exists?(name)
    end
  end
end
