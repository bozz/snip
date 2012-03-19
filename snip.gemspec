# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','snip_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'snip'
  s.version = Snip::VERSION
  s.author = 'Boris Searles'
  s.email = 'boris@lucidgardens.com'
  s.homepage = 'http://github.com/bozz/snip'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A Command Line Snippet Manager'
# Add your other files here if you make them
  s.files = %w(
bin/snip
lib/snip.rb
lib/snip_version.rb
lib/snip/commands.rb
lib/snip/command/list.rb
lib/snip/command/show.rb
lib/snip/command/add.rb
lib/snip/command/remove.rb
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','snip.rdoc']
  s.rdoc_options << '--title' << 'snip' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'snip'
  s.add_runtime_dependency('gli', ["~> 1.4"])
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('minitest-reporters')
  s.add_development_dependency('fakefs')
end
