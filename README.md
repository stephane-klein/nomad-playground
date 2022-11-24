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

## Start nomad on myserver1

```
$ vagrant ssh
$ sudo su
# nomad agent -dev -bind 0.0.0.0 -log-level INFO
...
    2022-11-24T08:38:36.629Z [INFO]  nomad.raft: entering candidate state: node="Node at 10.0.2.15:4647 [Candidate]" term=2
    2022-11-24T08:38:36.629Z [INFO]  nomad.raft: election won: term=2 tally=1
    2022-11-24T08:38:36.629Z [INFO]  nomad.raft: entering leader state: leader="Node at 10.0.2.15:4647 [Leader]"
    2022-11-24T08:38:36.630Z [INFO]  nomad: cluster leadership acquired
    2022-11-24T08:38:36.631Z [INFO]  nomad.core: established cluster id: cluster_id=02427b33-add4-6681-da8e-3a05341ea187 create_time=1669279116631843802
    2022-11-24T08:38:36.632Z [INFO]  nomad: eval broker status modified: paused=false
    2022-11-24T08:38:36.632Z [INFO]  nomad: blocked evals status modified: paused=false
    2022-11-24T08:38:36.633Z [INFO]  nomad.keyring: initialized keyring: id=ac58c048-f207-aafb-4568-8fa07522e53e
    2022-11-24T08:38:36.695Z [INFO]  client: node registration complete
    2022-11-24T08:38:37.697Z [INFO]  client: node registration complete
```

## Install Nomad client on Fedora

```
$ sudo dnf install -y dnf-plugins-core
$ sudo dnf config-manager --add-repo https://rpm.releases.hashicorp.com/fedora/hashicorp.repo
$ sudo dnf -y install nomad
```

```sh
$ direnv allow
$ nomad node status
ID        DC   Name       Class   Drain  Eligibility  Status
1ad1528a  dc1  myserver1  <none>  false  eligible     ready
$ nomad status
No running jobs

$ nomad server members
Name              Address    Port  Status  Leader  Raft Version  Build  Datacenter  Region
myserver1.global  10.0.2.15  4648  alive   true    3             1.4.3  dc1         global
```

## Run first job

```
$ nomad job run example.nomad
==> 2022-11-24T10:05:58+01:00: Monitoring evaluation "91877c91"
    2022-11-24T10:05:58+01:00: Evaluation triggered by job "example"
    2022-11-24T10:05:58+01:00: Evaluation within deployment: "1084eb62"
    2022-11-24T10:05:58+01:00: Allocation "f36eaa20" created: node "993689a0", group "cache"
    2022-11-24T10:05:58+01:00: Evaluation status changed: "pending" -> "complete"
==> 2022-11-24T10:05:58+01:00: Evaluation "91877c91" finished with status "complete"
==> 2022-11-24T10:05:58+01:00: Monitoring deployment "1084eb62"
  ⠼ Deployment "1084eb62" in progress...

    2022-11-24T10:06:23+01:00
    ID          = 1084eb62
    Job ID      = example
    Job Version = 0
    Status      = running
    Description = Deployment is running

    Deployed
    Task Group  Desired  Placed  Healthy  Unhealthy  Progress Deadline
    cache       1        1       0        0          2022-11-24T09:15:58Z^Z
[1]  + 622059 suspended  nomad job run example.nomad
```

```
$ vagrant ssh
$ sudo su
# docker ps
CONTAINER ID   IMAGE     COMMAND                  CREATED          STATUS          PORTS                                                  NAMES
8b6fbec6eb4c   redis:7   "docker-entrypoint.s…"   56 seconds ago   Up 55 seconds   127.0.0.1:30280->6379/tcp, 127.0.0.1:30280->6379/udp   redis-f36eaa20-3df7-50b9-80d7-44fca6531eb5
```
