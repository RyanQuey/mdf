from unitTest.helper_classes.test_case import TestCase

class TestMdfConf(TestCase):
    def sum(self):
        assert sum([1, 2, 3]) == 6, "Should be 6"

    def run(self):
        self.sum()
