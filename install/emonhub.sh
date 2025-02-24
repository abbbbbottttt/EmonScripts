#!/bin/bash
source load_config.sh

echo "-------------------------------------------------------------"
echo "emonHub install"
echo "-------------------------------------------------------------"
cd $openenergymonitor_dir

if [ ! -d $openenergymonitor_dir/emonhub ]; then
    git clone -b $emonhub_branch ${git_repo[emonhub]}
else 
    echo "- emonhub repository already installed"
    echo "- emonhub running git pull:"
    git -C $openenergymonitor_dir/emonhub pull
fi

if [ -f $openenergymonitor_dir/emonhub/install.sh ]; then
    $openenergymonitor_dir/emonhub/install.sh $emonSD_pi_env $user
else
    echo "ERROR: $openenergymonitor_dir/emonhub/install.sh script does not exist"
fi

# Sudoers entry (review!)
sudo visudo -cf $openenergymonitor_dir/EmonScripts/sudoers.d/emonhub-sudoers && \
sudo cp $openenergymonitor_dir/EmonScripts/sudoers.d/emonhub-sudoers /etc/sudoers.d/
sudo chmod 0440 /etc/sudoers.d/emonhub-sudoers
echo "emonhub service control sudoers entry installed"
