# Ensure we require the local version and not one we might have installed already
require File.join([File.dirname(__FILE__),'lib','snip_version.rb'])
spec = Gem::Specification.new do |s| 
  s.name = 'snip'
  s.version = Snip::VERSION
  s.author = 'Your Name Here'
  s.email = 'your@email.address.com'
  s.homepage = 'http://your.website.com'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A description of your project'
# Add your other files here if you make them
  s.files = %w(
bin/snip
  )
  s.require_paths << 'lib'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README.rdoc','snip.rdoc']
  s.rdoc_options << '--title' << 'snip' << '--main' << 'README.rdoc' << '-ri'
  s.bindir = 'bin'
  s.executables << 'snip'
  #s.add_runtime_dependency(%q<trollop>, ["~> 1.16"])
  s.add_development_dependency('rake')
  s.add_development_dependency('rdoc')
  s.add_development_dependency('minitest-reporters')
  s.add_development_dependency('fakefs')
end
