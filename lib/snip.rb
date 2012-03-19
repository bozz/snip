module Snip

  DEFAULT_DIR = '~/.snip'
  INSTALL_DIR = File.expand_path(Snip::DEFAULT_DIR)

  class NotInitializedError < StandardError ; end
  class DuplicateSnippetNameError < StandardError ; end
  class SnippetNotFoundError < StandardError ; end


  def self.open_editor(file_path)
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

  def self.snippet_exists?(name)
    File.exists?(File.join(Snip::INSTALL_DIR, name))
  end
end
