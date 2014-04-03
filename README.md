# VUPPUDJ

A simple Vagrant setup to run a Django project during development. It uses 
Ubuntu server 12.04 (x86_64) and Phusion Passenger, with an Upstart script to
run Passenger. It uses a simple script provisioner.

## Prerequisites

Your Django project must have a `setup.sh` in the root of the project that runs 
all necessary setup. At a bare minimum `setup.sh` should have:

    pip install Django

It must also have a passenger_wsgi.py file that can run from the `django` 
folder of VUPPUDJ (i.e., one level above where your project directory will 
sit -- the passenger_wsgi.py file gets copied outside of the project directory 
to mimic the setup that some web hosts use).

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

Start Vagrant:

    vagrant up

You can verify that your instance is running by visiting [http://localhost:3000]. 
