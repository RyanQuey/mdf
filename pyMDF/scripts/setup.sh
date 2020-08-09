#!/bin/bash

# TODO move this into the root project's scripts dir, so it's all in one place. Or alternatively, move those scripts into mMdf so stuff is kept separate.

# make sure we are in the current folder so venv relative paths work
cd "$(dirname "$0")/.."

# setup venv
# NOTE if ran from this script, doesn't activate in the terminal you called this script from
python3 -m venv venv && \
. venv/bin/activate && \

# install Python dependencies
pip3 install wheel
pip3 install -r ./requirements.txt
pip3 install -r ./mdf_playground/requirements.txt

# start the notebook 
# TODO add an option so that this isn't started. Or better yet, maybe split it out into a separate script; one for setup, one for running
python3 -m jupyter lab
