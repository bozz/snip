class Snip

  def self.init
    root_dir = File.expand_path('~')
    unless File.exists?("#{root_dir}/.snips")
      puts "...initializing ~/.snips directory"
      `mkdir $HOME/.snips`
    end
  end


  def self.add(snippet)
    Snip.init
    `vim "$HOME/.snips/#{snippet}" 3>&1 1>&2 2>&3`
    puts "...added new snippet: #{snippet}"
  end


  def self.edit(snippet)
    Snip.init
    root_dir = File.expand_path('~')
    target_file = "#{root_dir}/.snips/#{snippet}"
    if File.exists?(target_file)
      `vim "#{target_file}" 3>&1 1>&2 2>&3`
    else
      puts "Snippet #{snippet} could not be found"
    end
  end


  def self.list(query)
    Snip.init
    root_dir = File.expand_path('~')
    Dir.foreach("#{root_dir}/.snips") do |file|
      unless File.directory?(file)
        puts file
      end
    end
  end


  def self.rm(snippet)
    Snip.init
    root_dir = File.expand_path('~')
    target_file = "#{root_dir}/.snips/#{snippet}"
    if File.exists?(target_file)
      `rm #{target_file}`
      puts "Snippet #{snippet} was deleted"
    else
      puts "Snippet #{snippet} could not be found"
    end
  end


  def self.show(snippet)
    Snip.init
    root_dir = File.expand_path('~')
    target_file = "#{root_dir}/.snips/#{snippet}"
    if File.exists?(target_file)
      puts `cat #{target_file}`
    else
      puts "Snippet #{snippet} could not be found"
    end
  end


  def self.run(snippet)
    Snip.init
    root_dir = File.expand_path('~')
    target_file = "#{root_dir}/.snips/#{snippet}"
    if File.exists?(target_file)
      puts `cat #{target_file}`
      puts `cat #{target_file} | sh`
    else
      puts "Snippet #{snippet} could not be found"
    end
  end
end
