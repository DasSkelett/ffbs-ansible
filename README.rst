===================================
 Ansible for Freifunk Braunschweig
===================================

These are the ansible files for the Freifunk Braunschweig infrastructure. We are
using Vagrant and custom debian jessie images for local testing, a eployed
infrastructure is not online yet. The provider for vagrant is `libvirt`.

Requirements
============

- Ansible >= 2.4
- Vagrant >= 2.0

Installation
============

**NOTE**: To read the vault.gpg file for ansible vault, your gpg key has to be
added there. Contact Emantor, Kasalehlia or Shoragan for this.

Install the vagrant libvirt plugin:

::

   vagrant plugin install vagrant-libvirt

Example `Vagrantfile` from `~/.vagrant.d/Vagrantfile`:

::

   Vagrant.configure("2") do |config|
     config.vm.synced_folder "./", "/vagrant", type: "rsync"
   
     config.vm.provider :libvirt do |libvirt|
       libvirt.driver = "kvm"
       libvirt.storage_pool_name = "Images"
       libvirt.connect_via_ssh = false
       libvirt.username = "root"
       libvirt.cpu_mode = "host-passthrough"
     end
   end

adjust `libvirt.storage_pool_name` to your pool name.

Next, download the git repository and change into it:

::

   git clone https://gitli.stratum0.org/ffbs/ffbs-ansible.git
   cd ffbs-ansible

Now you can start the machines, vagrant will download the images as necessary
and provision the machines after creating them:

::

   vagrant up

Fedora specials
---------------
First get vagrant > 2.0, as it is not in the repo use the CentOS `rpm <https://www.vagrantup.com/downloads.html>`_.
Then install it with:

::

   sudo dnf install <path/to/your/vagrant.rpm>

After that you need to install a plugin with a specified version of vagrant-spec. With vagrant-spec installed you can install vagrant-libvirt. Use the following to do both:

::

   vagrant plugin install vagrant-cucumber
   vagrant plugin install vagrant-libvirt

And now, let's hope it works.


Development
===========

**NOTE**: Pushing to the repository requires membership in the ffbs group and
permissions for the repository, ask Emantor, Shoragan or Kasalehlia for those.

Commit your changes, make sure that all changes pass

::

   vagrant provision

and commit them to your repository. Then push via

::

   git push origin master
