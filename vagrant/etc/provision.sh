#!/bin/bash

PROJECT_NAME=$1

VIRTUALENVS_HOME=/home/vagrant/.virtualenvs
VIRTUALENV_DIR=$VIRTUALENVS_HOME/$PROJECT_NAME
PROJECT_DIR=/home/vagrant/$PROJECT_NAME
PACKAGES="build-essential python python-dev python-setuptools
    python-virtualenv python-pip libjpeg-dev libtiff-dev zlib1g-dev
    python-software-properties virtualenvwrapper
    libfreetype6-dev liblcms2-dev libpq-dev git vim-nox"
PGSQL_VERSION=9.1

apt-get update -y

# Install essential packages from Apt
apt-get -y install $PACKAGES

# Set project name in home directory
if [[ ! -f  /home/vagrant/.project_name ]] ; then
    echo "$PROJECT_NAME" > /home/vagrant/.project_name
fi

# .bashrc
BASHRC_LINE="source /vagrant/vagrant/etc/bashrc.sh"
if ! grep -Fxq "$BASHRC_LINE" /home/vagrant/.bashrc
then
    echo "$BASHRC_LINE" >> /home/vagrant/.bashrc
fi


# Postgresql
if ! command -v psql; then
    echo should install pgsql
    apt-get install -y postgresql-9.1
    # Additional postgresql setup goes here...
    #cp $PROJECT_DIR/vagrant/etc/install/pg_hba.conf /etc/postgresql/$PGSQL_VERSION/main/
    #/etc/init.d/postgresql reload
fi

# This should, maybe, get NPM installed
if ! command -v npm; then
    echo "Installing NPM..."
    apt-get -y install python-software-properties
    add-apt-repository ppa:chris-lea/node.js
    apt-get -y update
    apt-get -y install nodejs # Will also install npm
    npm config set registry http://registry.npmjs.org/
else
    echo "NPM already installed - skipping"
fi

# NPM & Yuglify
if ! command -v yuglify ; then
    npm -g install yuglify
fi

# Sass
if ! command -v sass ; then
    gem install sass
fi

# Project virtualenv
if [[ ! -d  $VIRTUALENV_DIR ]] ; then
    su - vagrant -c "mkdir -p $VIRTUALENVS_HOME && virtualenv $VIRTUALENV_DIR"
fi
su - vagrant -c "source $VIRTUALENV_DIR/bin/activate && pip install -r $PROJECT_DIR/requirements.txt"

# Heroku
if ! command -v heroku ; then
    wget -qO- https://toolbelt.heroku.com/install-ubuntu.sh | sh
fi
