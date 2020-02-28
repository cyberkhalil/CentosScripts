#!/bin/bash
# This script mession is to make the fisrt setup to the centos server as i wish

# function ask to yes no questions
ask(){ $(whiptail --yesno "$1" 20 60 3>&2 2>&1 1>&3); return $?;}

#update the system because why not :p
ask "Do you want to update the system ?"
if [ $? == 0 ]; then
    echo "Updating the system"
    dnf -yq update
fi

# solve dnf auto complete problem
ask "Do you want to solve dnf completion problem ?"
if [ $? == 0 ]; then
    echo "enable auto complete for dnf"
    complete -c dnf -w yum
fi

ask "Do you want to install vbox guests ?"
if [ $? == 0 ]; then
    dnf -yq install dkms bzip2 # install vbox guest requirements
    if (ask "Insert vbox guest iso (yes if you did, no if you didn't)"); then # request insert virtualbox guest iso
        mkdir /tmp/vbiso/
        mount /dev/cdroom /tmp/vbiso
        ./tmp/vbiso/VBoxLinuxAdditions.run
    fi
fi
