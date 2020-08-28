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
pip3 install -r ./tests/requirements.txt

# make all local packages available to each other
pip3 install -e .

printf "To run all the tests, simply call: \n\ncd "$(dirname "$0")/.."\n. venv/bin/activate\npytest\n\n and the tests should all run"
