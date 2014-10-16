# VUPPUDJ

A simple Vagrant setup to run a Django project during development. It uses
Ubuntu server 12.04 (x86_64) and Phusion Passenger, with an Upstart script to
run Passenger. It uses a simple script provisioner.

The project also provides the following tools for your new Ubuntu environment:

* pip
* virtualenv
* git
* mercurial
* subversion

## Prerequisites

Your Django project must have a `setup.sh` in the root of the project that runs
all necessary setup. At a bare minimum `setup.sh` should have:

    pip install Django

The setup script should be able to be run from any directory on the guest
machine. The path to your project folder will be `/vagrant/django/<your project>`,
so you may want to `cd` to the directory before starting or use absolute paths
when running your script.

Your project must also have a `passenger_wsgi.py` file to run your Django
project. See the 'Usage' section below for configuring `project.cfg` to point
to your `passenger_wsgi.py` file.

## Usage

Clone this repository onto your development machine:

    git clone https://github.com/kamni/vuppudj.git

Copy the Django project that you wish to run into the `django` folder
of this project (or clone it from your repository):

    cp -r /path-to-myproj/myprojname /path-to-vuppudj/myprojname

Create a project.cfg file in the root of vuppudj:

    cd /path-to-vuppudj
    cp project.cfg.example project.cfg

Set the absolute path on the VM to the folder where your passenger_wsgi.py file
will be located.  Unless you have other configuration needs, this should be
something like:

    WSGI_PATH='/vagrant/django/myprojname'

Create a ports.cfg file in the root of vuppudj:

    cp ports.cfg.example ports.cfg

Modify the PORTS variable to include a list of any ports that you would like 
mapped between Vagrant (the guest) and your local machine (the host).  For 
example, if you wanted to see Apache's port 80 on the Vagrant box show up when 
you visit http://localhost:8080/ on your computer, your config would look like:

    PORTS = [[80, 8080]]

Finally, start Vagrant:

    vagrant up

