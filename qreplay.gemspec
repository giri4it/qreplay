# encoding: utf-8
Gem::Specification.new do |gem|
  gem.add_runtime_dependency 'cast-ssh'
  gem.add_runtime_dependency 'pcap_tools'
  gem.add_runtime_dependency 'trollop'

  gem.authors = ["Peter Bakkum"]
  gem.bindir = 'bin'
  gem.description = %q{Capture and replay HTTP traffic}
  gem.email = ['peter@quizlet.com']
  gem.executables = ['qreplay']
  gem.extra_rdoc_files = ['LICENSE.md', 'README.md']
  gem.files = Dir['LICENSE.md', 'README.md', 'qreplay.gemspec', 'Gemfile', 'bin/*']
  gem.homepage = 'http://github.com/quizlet/qreplay'
  gem.name = 'qreplay'
  gem.rdoc_options = ["--charset=UTF-8"]
  gem.require_paths = ['lib']
  gem.required_rubygems_version = Gem::Requirement.new(">= 1.3.6")
  gem.summary = %q{Capture and replay HTTP traffic}
  gem.version = '1.0.0'
  gem.license = 'MIT'
end

