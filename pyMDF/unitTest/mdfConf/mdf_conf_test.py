from unitTest.helper_classes.test_case import TestCase
from core.mdfConf import mdfConf

class TestMdfConf(TestCase):
    def test_instantiate(self):
        conf_instance = mdfConf(self.xmlConfFile)

        # test that it got the param
        assert conf_instance.filename == self.xmlConfFile

    def run(self):
        self.test_instantiate()


    def setup(self):
        # call parent class setup
        super(TestMdfConf, self).setup()

        # set up input data that will be used to instantiate the object and have it ready for use
        self.indata = [
            {
                'fileName', self.xmlConfFile,
                'automation', 'start',
                'menuType', 'text',
                'selection', 1
            },
            {
                'fileName', self.xmlConfFile,
                'automation', 'start',
                'menuType', 'text',
                'selection', 2
            },
            {
                'fileName', self.xmlConfFile,
                'automation', 'start',
                'menuType', 'text',
                'selection', 3
            }
        ]
