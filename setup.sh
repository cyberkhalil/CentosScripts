#!/bin/bash
# This script mession is to make the fisrt setup to the centos server as i wish

# function ask to yes no questions
ask(){ $(whiptail --yesno "$1" 20 60 3>&2 2>&1 1>&3); return $?;}

#update the system because why not :p
ask "Do you want to update the system ?"
if [ $? = 0 ]; then
    echo "Updating the system"
    dnf -y update
fi

# solve dnf auto complete problem
ask "Do you want to solve dnf autocompletion problem ? (recommended dnf has problem in completion)"
if [ $? = 0 ]; then
    yum -y reinstall bash-completion sqlite
    complete -c dnf -w yum
    if [ -e /usr/share/bash-completion/completions/dnf ]; then
        rm -f /usr/share/bash-completion/completions/dnf
        echo "complete -c dnf -w yum" >> /etc/profile
    fi
fi

ask "Do you want to install vbox guests ?"
if [ $? = 0 ]; then
    dnf -y install dkms bzip2 # install vbox guest requirements
    if (ask "Insert vbox guest iso (yes if you did, no if you didn't)"); then # request insert virtualbox guest iso
        mkdir /tmp/vbiso/
        mount /dev/cdrom /tmp/vbiso
        ./tmp/vbiso/VBoxLinuxAdditions.run
        umount /tmp/vbiso
    fi
fi

# install nano
ask "Do you want to install nano ?"
if [ $? = 0 ]; then
    yum -y install nano
fi

# install nano
ask "reboot ? (recommended for dnf-completion,virtualbox guest)"
if [ $? = 0 ]; then
    reboot
fi
