require 'vagrant'

module VagrantPlugins
	module EtcHosts
		class Config < Vagrant.plugin("2", :config)
			attr_accessor :aliases

			def initialize
				@aliases = UNSET_VALUE
			end

			def finalize!
				@aliases = [] if @aliases == UNSET_VALUE
			end

			def validate(machine)
			end
		end
	end
end
