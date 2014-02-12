require 'git-version-bump'

module VagrantPlugins
	module EtcHosts
		VERSION_MAJOR = GVB.major_version
		VERSION_MINOR = GVB.minor_version
		VERSION_PATCH = GVB.patch_version
	
		VERSION = GVB.version
	end
end
