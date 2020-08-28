# What is pyMDF?
pyMDF is a python implementation of mdf. This allows reading and writing the same data that mMdf does, but in the python language. Data stored by mMdf in your db can be read by pyMDF and vice versa.

# Setup 
## Start with Jupyter tutorial
Just run `./script/setup.sh`. This will open a jupyter lab notebook for you, which walks you through a tutorial to MDF.

## Go a little deeper
Setup environment by making a `.env` file and setting your env vars.
```
cp .env.sample .env
vim .env
```

# Run all unit tests
```
./scripts/setup-tests.sh
. venv/bin/activate
pytest
```
