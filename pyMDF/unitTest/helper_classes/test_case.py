class TestCase:
    """
    Parent class for our test cases
    - since all will inherit test_setup_and_run, and test_setup_and_run has "test" as first part of its name, pytest will run that for all test cases
    - Note that until we rename this one, it will also run...but that's ok
    """
    def setup(self):
        pass

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
