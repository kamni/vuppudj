# bring in configured variables
source /vagrant/project.cfg

# python essentials
apt-get install -y build-essential python-dev

# pip
cd /vagrant/downloads
python distribute_setup.py
easy_install pip

# adding phusion passenger repository
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 561F9B9CAC40B2F7
apt-get install -y apt-transport-https ca-certificates
cp /vagrant/config/etc/apt/sources.list.d/passenger.list /etc/apt/sources.list.d/
chown root:root /etc/apt/sources.list.d/passenger.list
chmod 600 /etc/apt/sources.list.d/passenger.list
apt-get update

# installing phusion
apt-get install -y passenger

# installing upstart so this will run when we restart
apt-get install -y upstart
cp /vagrant/config/etc/init/passenger.conf /etc/init/
initctl reload-configuration

# setting up django
cd /vagrant/django
cp $PROJECT/passenger_wsgi.py .
if [ -e $PROJECT/"setup.sh" ]; then
  ./$PROJECT/setup.sh
fi

passenger start --daemonize --user vagrant
