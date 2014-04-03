# VUPPUDJ

A simple Vagrant setup to run a Django project during development. It uses
Ubuntu server 12.04 (x86_64) and Phusion Passenger, with an Upstart script to
run Passenger. It uses a simple script provisioner.

## Prerequisites

Your Django project must have a `setup.sh` in the root of the project that runs
all necessary setup. At a bare minimum `setup.sh` should have:

    pip install Django

The setup script should be able to be run from any directory on the guest
machine. The path to your project folder will be `/vagrant/django/<your project>`,
so you may want to `cd` to the directory before starting or use absolute paths
when running your script.

Your project must also have a passenger_wsgi.py file to run your Django
project. See the 'Usage' section below for configuring `project.cfg` to point
to your passenger_wsgi.py file.

## Usage

Clone this repository onto your development machine:

    git clone https://github.com/kamni/vuppudj.git

Link or copy the Django project that you wish to run into the `django` folder
of this project. For example, if you are on a *nix machine, you might do:

    ln -s /path-to-myproj/myprojname /path-to-vuppudj/myprojname

Create a project.cfg file in root of vuppudj:

    cd /path-to-vuppudj
    cp project.cfg.example project.cfg

Edit the `PROJECT` variable to match the project you copied into `django`:

    PROJECT='myprojname'  # change to your actual project folder name

Set the absolute path on the VM to the folder where your passenger_wsgi.py file
will be located.  Unless you have other configuration needs, this should be
something like:

    WSGI_PATH='/vagrant/django/myprojname'

You may also want to edit the `HOST_PORT` variable if you are running multiple
vagrant instances, but the default setting of 3000 should work without
modification if you are only running one instance.

Start Vagrant:

    vagrant up

You can verify that your instance is running by visiting [http://localhost:3000]
(or whatever port you specified in `project.cfg`).
