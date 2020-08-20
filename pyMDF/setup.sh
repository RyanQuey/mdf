#!/bin/bash

# make sure we are in the current folder so venv relative paths work
cd "$(dirname "$0")"

# setup venv
# NOTE if ran from this script, doesn't activate in the terminal you called this script from
python3 -m venv venv && \
. venv/bin/activate && \

# install Python dependencies
pip3 install wheel
pip3 install -r ./requirements.txt
# these libs are only strictly necessary for 
pip3 install -r ./mdf_playground/requirements.txt

# start the notebook 
python3 -m jupyter lab
