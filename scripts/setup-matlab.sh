#!/bin/bash -eux

if [ "$BASH" != "/bin/bash" ]; then
  echo "Please do ./$0"
  exit 1
fi

# always base everything relative to this file to make it simple
parent_path=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

export MDF_PROJECT_ROOT_PATH=$parent_path/..
# will be defined to whatever it was set to before, or default to user's home dir as was recommended in the readme
export MDF_CONF_PATH=${MDF_CONF_PATH:-$HOME/mdf}
matlab_version=${MATLAB_VERSION:-"R2020a"}

# install this to make sure to be able to use envsubst (used just for this script)
sudo apt-get install gettext-base

#########################################
# add some jars to the matlab classpath
matlab_configs_path=$HOME/.matlab/$matlab_version
touch $matlab_configs_path/javaclasspath.txt && \
# for now appending to the javaclasspath, so we don't erase what might already be there
cat $parent_path/files-for-setup/javaclasspath.txt >> $matlab_configs_path/javaclasspath.txt

# substitute any env vars within javaclasspath.txt for their actual values
envsubst < $matlab_configs_path/javaclasspath.txt

# to make sure it worked, can run this in the matlab console:
#
#   javaclasspath

# and then check to see if the java classes from javaclasspath.txt are there

#########################################
# setup the mdf data and conf dirs
mkdir -p $MDF_CONF_PATH/conf
mkdir -p $MDF_CONF_PATH/data
# this should already exist (I think Matlab makes it?), but just to make sure
mkdir -p ~/Documents/MATLAB/

# just need it somewhere that is on matlab's path. ~/Documents/MATLAB/ works just fine
cp $parent_path/files-for-setup/startMdf.m ~/Documents/MATLAB/

# substitute any env vars within startMdf.m for their actual values
envsubst < ~/Documents/MATLAB/startMdf.m

# provide an example conf xml file
cp $parent_path/files-for-setup/mdf.conf.xml $MDF_CONF_PATH/conf/
# substitute any env vars 
envsubst < $MDF_CONF_PATH/conf/mdf.conf.xml
