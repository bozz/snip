module Snip

  DEFAULT_DIR = '~/.snip'
  INSTALL_DIR = File.expand_path(Snip::DEFAULT_DIR)

  class NotInitializedError < StandardError ; end
  class DuplicateSnippetNameError < StandardError ; end
  class SnippetNotFoundError < StandardError ; end


  def self.open_editor(file_path)
    puts "editor: #{$EDITOR}"
    `vim "#{file_path}" 3>&1 1>&2 2>&3`
  end

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

    # def self.add(args, options={})
    #   name, content = args
    #   raise NotInitializedError unless Snip::initialized?
    #   raise DuplicateSnippetNameError if Snip::Snippet::exists?(name)

    #   file_path = File.join(Snip::INSTALL_DIR, name)
    #   if content.nil?
    #     raise ArgumentError
    #     # Snip::open_editor(file_path)
    #   else
    #     File.open(file_path, 'w') do |f|
    #       f.puts content
    #     end
    #   end
    # end

    def self.show(args, options={})
      name = args
      raise NotInitializedError unless Snip::initialized?
      raise SnippetNotFoundError unless Snip::Snippet::exists?(name)

      puts File.read(File.join(Snip::INSTALL_DIR, name))
    end

    def self.list(args=[], options={})
      raise NotInitializedError unless Snip::initialized?

      Dir.foreach(Snip::INSTALL_DIR) do |file|
        next if file == '.' or file == '..'
        puts "#{file}"
      end
    end

    def self.remove(args, options={})
      name = args
      raise NotInitializedError unless Snip::initialized?
      raise SnippetNotFoundError unless Snip::Snippet::exists?(name)

      FileUtils.rm(File.join(Snip::INSTALL_DIR, name)) if Snip::Snippet::exists?(name)
    end
  end
end
