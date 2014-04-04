SPACER="===== "

# bring in configured variables
echo $SPACER"bootstrap: importing project config"
source /vagrant/project.cfg

# adding phusion passenger repository
echo $SPACER"bootstrap: adding Phusion repositories"
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates
cp /vagrant/config/etc/apt/sources.list.d/passenger.list /etc/apt/sources.list.d/
chown root:root /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get update

# python essentials
echo $SPACER"bootstrap: installing build-essential"
apt-get install -y build-essential
echo $SPACER"bootstrap: installing python-dev"
apt-get install -y python-dev
echo $SPACER"bootstrap: installing sqlite3"
apt-get install -y sqlite3

# pip and virtualenv
echo $SPACER"bootstrap: installing distribute"
cd /vagrant/downloads
python distribute_setup.py
echo $SPACER"bootstrap: installing pip"
easy_install pip
echo $SPACER"bootstrap: installing virtualenv"
pip install virtualenv

# other tools
echo $SPACER"bootstrap: installing subversion"
apt-get install -y subversion
echo $SPACER"bootstrap: installing mercurial"
apt-get install -y mercurial
echo $SPACER"bootstrap: installing git"
apt-get install -y git

# installing phusion
echo $SPACER"bootstrap: installing Phusion Passenger"
apt-get install -y passenger

# installing upstart so this will run when we restart
echo $SPACER"bootstrap: installing upstart"
apt-get install -y upstart
cp /vagrant/config/etc/init/passenger.conf /etc/init/
initctl reload-configuration

# setting up django
echo $SPACER"bootstrap: setting up Django project"
cd /vagrant/django
if [ -e $PROJECT/"setup.sh" ]; then
  /bin/bash $PROJECT/setup.sh
fi

# starting Passenger for the first time (should automatically start next time
# the virtual machine is restarted)
echo $SPACER"bootstrap: starting Passenger"
cd $WSGI_PATH
passenger start --daemonize --user vagrant

echo $SPACER"bootstrap: setup complete"
