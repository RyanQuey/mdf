#!/bin/bash -eux

# these are the setup actions that are required whether using matlab or python

if [ "$BASH" != "/bin/bash" ]; then
  echo "Please do ./$0"
  exit 1
fi

# always base everything relative to this file to make it simple
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# where the repo lives on your computer
export MDF_PROJECT_ROOT_PATH=$parent_path/..

# will be defined to whatever it was set to before, or default to user's home dir as was recommended in the readme
export MDF_CONF_PATH=${MDF_CONF_PATH:-$HOME/mdf}

# install this to make sure to be able to use envsubst (used just for this script)
sudo apt-get install gettext-base

#########################################
# setup the mdf data and conf dirs
mkdir -p $MDF_CONF_PATH/conf
mkdir -p $MDF_CONF_PATH/data

# provide an example working conf xml file
# substitute any env vars 
echo "Copying mdf.conf.xml to: $MDF_CONF_PATH/conf/mdf.conf.xml"
envsubst < $parent_path/files-for-setup/mdf.conf.xml > $MDF_CONF_PATH/conf/mdf.conf.xml 

# another xml file for unitTesting in mMDF or pyMDF
# just leave it here, might as well set this one config file in both places. Makes sure all env vars are right
echo "Copying mdf.conf.xml.for_unitTest to: $MDF_PROJECT_ROOT_PATH/mMDF/unitTest/conf/mdf.xml.conf"
export MDF_IMPLEMENTATION=mMDF
envsubst < $parent_path/files-for-setup/mdf.conf.xml.for_unitTest > $MDF_PROJECT_ROOT_PATH/mMDF/unitTest/conf/mdf.xml.conf

export MDF_IMPLEMENTATION=pyMDF
echo "Copying mdf.conf.xml.for_unitTest to: $MDF_PROJECT_ROOT_PATH/pyMDF/unitTest/conf/mdf.xml.conf"
envsubst < $parent_path/files-for-setup/mdf.conf.xml.for_unitTest > $MDF_PROJECT_ROOT_PATH/pyMDF/unitTest/conf/mdf.xml.conf
