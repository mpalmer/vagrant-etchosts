module VagrantPlugins::EtcHosts
	class RemoveEtcHostsEntry
		ETC_HOSTS = '/etc/hosts'

		def initialize(app, env)
			@app = app
		end
		
		def call(env)
			id  = env[:machine].id
			return if id.nil? or id.empty?
			
			tmp = Tempfile.open('vagrant-etchosts', env[:tmp_path], 'w')
			
			begin
				tmp.write(File.readlines(ETC_HOSTS).reject { |l| l =~ /# VAGRANT ID: #{id}$/ }.join(""))
				
				tmp.close
				`sudo cp #{tmp.path} /etc/hosts`
				`sudo pkill -HUP dnsmasq`
			ensure
				tmp.close rescue nil
				tmp.unlink rescue nil
			end

			@app.call(env)
		end
	end
end
