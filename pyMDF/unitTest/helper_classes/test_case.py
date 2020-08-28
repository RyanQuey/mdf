from pathlib import Path
import os

# `path.parents[1]` is the same as `path.parent.parent`
unitTestPath = Path(__file__).resolve().parents[1]

class TestCase:
    """
    Parent class for our test cases
    - since all will inherit test_setup_and_run, and test_setup_and_run has "test" as first part of its name, pytest will run that for all test cases
    - Note that until we rename this one, it will also run...but that's ok
    """
    def setup(self):
        self.set_config_path()

    def run(self):
        """
        Run all the tests for this test case
        """
        pass

    def test_setup_and_run(self):
        """
        Everythings should run using this one call
        """
        self.setup()
        self.run()

    ################################
    # helper methods
    # - will be called by the above main methods
    # - will more often be overwritten by child classes than the above main methods
    ################################
    def set_config_path(self):
        """
        set path to our conf file for testing
        """
        self.xmlConfFile = os.path.join(unitTestPath, "conf", "mdf.xml.conf")
