require 'vagrant-etchosts/action/add_etc_hosts_entry'
require 'vagrant-etchosts/action/remove_etc_hosts_entry'
require 'vagrant-etchosts/config'

module VagrantPlugins::EtcHosts
	class Plugin < Vagrant.plugin("2")
		name 'EtcHosts'
		description <<-DESC.gsub(/^\t\t\t/, '')
			This plugin manages the /etc/hosts file on the host machine.
		DESC

		config(:etchosts) do
			VagrantPlugins::EtcHosts::Config
		end

		action_hook(:etchosts, :machine_action_up) do |hook|
			hook.after ::Vagrant::Action::Builtin::SetHostname, ::VagrantPlugins::EtcHosts::AddEtcHostsEntry
		end

		action_hook(:etchosts, :machine_action_destroy) do |hook|
			hook.prepend VagrantPlugins::EtcHosts::RemoveEtcHostsEntry
		end
	end
end
