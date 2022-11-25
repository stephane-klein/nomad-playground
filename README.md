# Nomad playground

Vagrant [Nomad](https://www.nomadproject.io/) playground with 3 nodes.

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
$ vagrant up
```

```sh
$ vagrant status
Current machine states:

myserver1                 running (virtualbox)
myserver2                 running (virtualbox)
myserver3                 running (virtualbox)
```


## Install Nomad client on Fedora

```sh
$ sudo dnf install -y dnf-plugins-core
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
$ sudo dnf -y install nomad
```

```sh
$ nomad server members
Name              Address       Port  Status  Leader  Raft Version  Build  Datacenter  Region
myserver1.global  192.168.56.9  4648  alive   true    3             1.4.3  dc1         global

nomad-playground on  workinprogress via ⍱ v2.2.19
$ nomad node status
ID        DC   Name       Class   Drain  Eligibility  Status
6cf480d7  dc1  myserver2  <none>  false  eligible     ready
6dbd0431  dc1  myserver3  <none>  false  eligible     ready
3b5f8a8a  dc1  myserver1  <none>  false  eligible     ready
```

## Run first job

```sh
$ nomad job run http-echo-hello.nomad
```

```
$ nomad job status
ID       Type     Priority  Status   Submit Date
example  service  50        running  2022-11-25T00:21:58+01:00
```

```sh
$ nomad job status example
ID            = example
Name          = example
Submit Date   = 2022-11-25T00:21:58+01:00
Type          = service
Priority      = 50
Datacenters   = dc1
Namespace     = default
Status        = running
Periodic      = false
Parameterized = false

Summary
Task Group  Queued  Starting  Running  Failed  Complete  Lost  Unknown
cache       0       0         1        0       0         0     0

Latest Deployment
ID          = 91477fad
Status      = successful
Description = Deployment completed successfully

Deployed
Task Group  Desired  Placed  Healthy  Unhealthy  Progress Deadline
cache       1        1       1        0          2022-11-24T23:32:17Z

Allocations
ID        Node ID   Task Group  Version  Desired  Status   Created    Modified
2ac79e39  3b5f8a8a  cache       0        run      running  15h8m ago  15h8m ago
```

```sh
$ vagrant ssh myserver1
$ sudo su
# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
8b6fbec6eb4c   redis:7   "docker-entrypoint.s…"   56 seconds ago   Up 55 seconds   127.0.0.1:30280->6379/tcp, 127.0.0.1:30280->6379/udp   redis-f36eaa20-3df7-50b9-80d7-44fca6531eb5
```
