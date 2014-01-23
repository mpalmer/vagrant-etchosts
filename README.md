# vagrant-etchosts

This is a Vagrant 1.4+ (at least, that's all I've tested it on) plugin to
add and remove entries from `/etc/hosts` on the machine on which Vagrant is
running.

It differs from the other plugins available to do this job in several ways:

 * It can detect and use dynamic IP addresses (DHCP FTW);

 * It doesn't *require* any plugin-specific configuration (it uses
   `config.vm.hostname` and the IP address assigned dynamically), although
   you can specify additional aliases if you choose;

 * It works on modern versions of Vagrant.

Its limitations are:

 * **It *only* updates the *host's* `hosts` file**: I'm using
   `vagrant-libvirt`, and libvirt provides a `dnsmasq` setup that will
   respond to DNS requests with entries from `/etc/hosts`.  If you need to
   have your guests `/etc/hosts` played with, patches are welcome.
 
 * **It doesn't handle statically-assigned addresses or multiple networks**:
   I haven't yet had a need for other addressing schemes, so I haven't added
   them yet.  If you want it, send me a patch or wait until I've found a
   need for multiple networks and/or statically assigned addresses.
