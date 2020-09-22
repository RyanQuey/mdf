# What is pyMDF?
pyMDF is a python implementation of mdf. This allows reading and writing the same data that mMdf does, but in the python language. Data stored by mMdf in your db can be read by pyMDF and vice versa.

# Setup 
## Setup MDF
Before doing anything else, first make sure you setup MDF
```
./scripts/setup-mdf.sh
```

## Start with Jupyter tutorial
Just run `./script/setup.sh`. This will open a jupyter lab notebook for you, which walks you through a tutorial to MDF.

# Testing
## Run all unit tests
```
./scripts/setup-tests.sh
. venv/bin/activate
pytest
```

## Add more tests
According to the [docs](https://docs.pytest.org/en/latest/getting-started.html#run-multiple-tests), "pytest will run all files of the form test_*.py or *_test.py in the current directory and its subdirectories. More generally, it follows standard test [discovery rules](https://docs.pytest.org/en/latest/goodpractices.html#test-discovery)."

We are putting all our tests in `./unitTest`.

We are also maintaining continuity by having tests inherit from our TestCase class.

### What to add next
* Go through existing test files (end in `*test.py`) and see if the run method has any tests that are commented out, and work on those
* Go through existing mMdf tests and see if there are any test directories there that have not yet been replicated into pyMDF. Probably do them in the same order found in mMdf.

# Mapping concepts from mMDF to pyMDF

## FakeSingleton
MDF classes that are singleton classes are mapped to Python classes that inherit from helpers/singleton.py. These are actually FakeSingletons, basically overwriting the __dict__ so that new objects share the same attributes.
