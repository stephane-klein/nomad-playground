#!/usr/bin/env bash
set -ev

sudo apt-get update -y
sudo apt-get upgrade -y
sudo apt-add-repository "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main"
