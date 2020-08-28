from setuptools import setup, find_packages
# following https://docs.pytest.org/en/stable/goodpractices.html
# this makes all packages in all subdirectories available to be imported by each other

setup(name="mdf", packages=find_packages())
