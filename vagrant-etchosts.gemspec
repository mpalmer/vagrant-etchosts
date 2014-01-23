# -*- encoding: utf-8 -*-

lib = File.expand_path('../lib', __FILE__)
$: << File.expand_path('../lib', __FILE__)

require 'vagrant-etchosts/version'

Gem::Specification.new do |gem|
	gem.name          = 'vagrant-etchosts'
	gem.version       = VagrantPlugins::EtcHosts::VERSION
	gem.authors       = ['Matt Palmer']
	gem.email         = ['theshed+vagrant-etchosts@hezmatt.org']
	gem.description   = %q{A Vagrant plugin that manages the /etc/hosts file on the host}
	gem.summary       = gem.description
	gem.license       = 'GPLv3'

	gem.files         = `git ls-files`.split($/)
	gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
	gem.require_paths = ['lib']
	
	gem.add_development_dependency 'bundler', '~> 1.3'
	gem.add_development_dependency 'rake'
end
			                  
