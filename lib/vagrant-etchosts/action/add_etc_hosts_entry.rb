require 'tempfile'

module VagrantPlugins::EtcHosts
	class AddEtcHostsEntry
		ETC_HOSTS = '/etc/hosts'
		
		def initialize(app, env)
			@app = app
		end
		
		def call(env)
			@app.call(env)
			
			# Best place to find the network config?  In the SSH config.
			addr = env[:machine].ssh_info[:host]
			fqdn = env[:machine].config.vm.hostname
			id   = env[:machine].id
			
			if fqdn.nil?
				fqdn = env[:machine].name.to_s
			end
			
			shortname = fqdn.split('.').first
			shortname = "" if shortname == fqdn
			
			tmp = Tempfile.open('vagrant-etchosts', env[:tmp_path], 'w')
			
			begin
				# Dump existing /etc/hosts content into our temp file
				tmp.write(File.read(ETC_HOSTS))
				tmp << "#{addr} #{fqdn} #{shortname}  # VAGRANT ID: #{id}\n"
				
				tmp.close
				`sudo cp #{tmp.path} /etc/hosts`
				`sudo pkill -HUP dnsmasq`
			ensure
				tmp.close rescue nil
				tmp.unlink rescue nil
			end
		end
	end
end
