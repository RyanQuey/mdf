#!/bin/bash -eux
# starts mongo in docker and matlab in cli mode, and then initializes some variables for us.
# NOTE assumes that you have run bash ./build_docker_images.bash already

if [ "$BASH" != "/bin/bash" ]; then
  echo "Please do ./$0"
  exit 1
fi

# always base everything relative to this file to make it simple
PARENT_PATH=$( cd "$(dirname "${BASH_SOURCE[0]}")" ; pwd -P )

# where the repo lives on your computer
export MDF_PROJECT_ROOT_PATH=$PARENT_PATH/..

# will be defined to whatever it was set to before, or default to user's home dir as was recommended in the readme
export MDF_CONF_PATH=${MDF_CONF_PATH:-$HOME/mdf}
MATLAB_VERSION=${MATLAB_VERSION:-"R2020a"}
###########################
# start mongo in docker
DOCKER_COMPOSE_DIR_PATH=$MDF_PROJECT_ROOT_PATH/test/db/
DOCKER_COMPOSE_FILE_PATH=$DOCKER_COMPOSE_DIR_PATH/docker-compose.yml

# build the mdf mongo image if does not exist
cd $DOCKER_COMPOSE_DIR_PATH
# we don't want to have to build our docker image every time, so make sure to run build_docker_images.bash once before running this startup script
# bash ./build_docker_images.bash && \

# starting in daemon mode
docker-compose up -d && \

# start matlab cli, initialize things with startMdf, then jump back into mdf/mMDF dir so we're ready to start
/usr/local/MATLAB/$MATLAB_VERSION/bin/matlab -nodesktop -nosplash -nodisplay \
  -r "cd ~/Documents; startMdf; cd $MDF_PROJECT_ROOT_PATH/mMDF"
