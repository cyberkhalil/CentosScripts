# This script mession is to make the fisrt setup to the centos server as i wish

ask(){ return whiptail --yesno $1 20 60;}

# update the system because why not :p
if [ ask "Do you want to update the system ?" ]; then
    echo "Updating the system"
    dnf update -q
fi

# solve dnf auto complete problem
if [ ask "Do you want to solve dnf completion problem ?" ]; then
    echo "enable auto complete for dnf"
    complete -c dnf -w yum
fi

if [ ask "Do you want to install vbox guests ?" ]; then
    dnf -y install dkms bzip2 # install vbox guest requirements
    if [ ask "Insert vbox guest iso (yes if you did, no if you didn't)" ]; then # request insert virtualbox guest iso
        mkdir /tmp/vbiso/
        mount /dev/cdroom /tmp/vbiso
        ./tmp/vbiso/VBoxLinuxAdditions.run
    fi
fi
