# Nomad playground

## Prerequisite

- Virtualbox
- Vagrant
- [vagrant-hostmanager](https://github.com/devopsgroup-io/vagrant-hostmanager) plugin

On OSX, execute this command with [brew](https://brew.sh/index_fr.html) to install this prerequisite :

```sh
brew cask install vagrant virtualbox
```

On Fedora install VirtualBox with https://github.com/stephane-klein/vagrant-virtualbox-fedora

```
$ sudo dnf install -y vagrant
```

```
$ vagrant plugin install vagrant-hostmanager --plugin-version 1.8.9
```


## Start Vagrant host

```sh
vagrant up
```

## Install Nomad client on Fedora

```
$ sudo dnf install -y dnf-plugins-core
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
$ sudo dnf -y install nomad
```

```sh
$ direnv allow
$ nomad status
No running jobs

$ nomad server members
Name              Address    Port  Status  Leader  Raft Version  Build  Datacenter  Region
myserver1.global  10.0.2.15  4648  alive   true    3             1.4.3  dc1         global
```
