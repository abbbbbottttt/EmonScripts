#!/bin/bash

user=$USER
openenergymonitor_dir=/opt/openenergymonitor
emoncms_dir=/opt/emoncms

sudo apt-get update -y
sudo apt-get install -y git-core

echo $user

sudo mkdir $openenergymonitor_dir
if [ "$user" != "root" ]; then
    sudo chown $user $openenergymonitor_dir
fi

sudo mkdir $emoncms_dir
if [ "$user" != "root" ]; then
    sudo chown $user $emoncms_dir
fi

cd $openenergymonitor_dir

git clone https://github.com/abbbbbottttt/EmonScripts.git
cd $openenergymonitor_dir/EmonScripts
git checkout docker