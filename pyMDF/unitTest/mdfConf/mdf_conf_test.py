from unitTest.helper_classes.test_case import TestCase
from core.mdfConf import mdfConf
from bs4 import BeautifulSoup

class TestMdfConf(TestCase):
    #########################
    # tests
    ########################
    def test_instantiate(self):
        mdf_conf = mdfConf(self.xmlConfFile)

        # test that it got the param
        assert mdf_conf.filename == self.xmlConfFile

    def test_load(self):
        # instantiate the object and load the configuration file
        mdf_conf = mdfConf(self.xmlConfFile)

        mdf_conf.load();

        # test that file has been loaded
        assert isinstance(mdf_conf.parsed_file, BeautifulSoup)

    ##########################
    # override parent class methods
    ########################
    def run(self):
        self.test_instantiate()
        self.test_load()
        # self.test_extraction()
        # self.test_selection()
        # self.test_automation()
        # self.test_configuration()
        # self.test_collection_conf()
        # self.test_constants()


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