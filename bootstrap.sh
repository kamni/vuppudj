SPACER="===== "

# bring in configured variables
echo $SPACER"bootstrap: importing project config"
source /vagrant/project.cfg

# adding phusion passenger repository
echo $SPACER"bootstrap: running apt-get update"
apt-get update --fix-missing

# development essentials
echo $SPACER"bootstrap: installing build-essential"
apt-get install -y build-essential
echo $SPACER"bootstrap: installing python-dev"
apt-get install -y python-dev
echo $SPACER"bootstrap: installing sqlite3"
apt-get install -y sqlite3
echo $SPACER"bootstrap: installing mysql"
debconf-set-selections <<< 'mysql-server mysql-server/root_password password MYSQL_PASSWORD'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password MYSQL_PASSWORD'
apt-get install -y mysql-server
echo $SPACER"bootstrap: installing postgres"
apt-get install -y postgresql
echo $SPACER"bootstrap: installing vim"
apt-get install -y vim
echo $SPACER"bootstrap: installing lynx"
apt-get install -y lynx

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

# installing compass
echo $SPACER"bootstrap: installing ruby"
apt-get install -y ruby-full rubygems
echo $SPACER"bootstrap: installing compass"
gem install compass sass

# niceties
echo $SPACER"bootstrap: setting up vagrant home"
ln -s /vagrant/django /home/vagrant/django
mkdir /home/venv
chown -R vagrant:vagrant /home/venv

echo $SPACER"bootstrap: setup complete"
