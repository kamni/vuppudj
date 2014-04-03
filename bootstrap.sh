# bring in configured variables
echo "bootstrap: importing project config"
source /vagrant/project.cfg

# adding phusion passenger repository
echo "bootstrap: adding Phusion repositories"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates
cp /vagrant/config/etc/apt/sources.list.d/passenger.list /etc/apt/sources.list.d/
chown root:root /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get update

# python essentials
echo "bootstrap: installing build-essential"
apt-get install -y build-essential
echo "bootstrap: installing python-dev"
apt-get install -y python-dev

# pip and virtualenv
echo "bootstrap: installing distribute"
cd /vagrant/downloads
python distribute_setup.py
echo "bootstrap: installing pip"
easy_install pip
echo "bootstrap: installing virtualenv"
pip install virtualenv

# other tools
echo "bootstrap: installing subversion"
apt-get install -y subversion
echo "bootstrap: installing mercurial"
apt-get install -y mercurial
echo "bootstrap: installing git"
apt-get install -y git

# installing phusion
echo "bootstrap: installing Phusion Passenger"
apt-get install -y passenger

# installing upstart so this will run when we restart
echo "bootstrap: installing upstart"
apt-get install -y upstart
cp /vagrant/config/etc/init/passenger.conf /etc/init/
initctl reload-configuration

# setting up django
echo "bootstrap: setting up Django project"
cd /vagrant/django
if [ -e $PROJECT/"setup.sh" ]; then
  /bin/bash $PROJECT/setup.sh
fi

# starting Passenger for the first time (should automatically start next time
# the virtual machine is restarted)
echo "bootstrap: starting Passenger"
cd $WSGI_PATH
passenger start --daemonize --user vagrant

echo "bootstrap: setup complete"
