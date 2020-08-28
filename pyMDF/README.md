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

## Add more tests
According to the [docs](https://docs.pytest.org/en/latest/getting-started.html#run-multiple-tests), "pytest will run all files of the form test_*.py or *_test.py in the current directory and its subdirectories. More generally, it follows standard test [discovery rules](https://docs.pytest.org/en/latest/goodpractices.html#test-discovery)."

We are putting all our tests in `./tests`.

We are also maintaining continuity by having tests inherit from our TestCase class.
