from helpers.singleton import FakeSingleton
from bs4 import BeautifulSoup
import json

class mdfConf(FakeSingleton):

    #############################
    # mdfConf default properties
    #############################
    # name of the file with the configuration
    filename = 'mdf.conf.xml'

    # read file as str
    raw_file_str = None

    # after parsing the xml/json
    parsed_file = None

    # type of configuration file
    fileType = 'unknown'

    # data read from configuration file
    fileData = None

    # configuration data structure
    confData = None

    # temp dictionary with configuration file
    temp = None

    # configuration selected
    selection = 0

    # automation
    automation = 'none'
    # TODO exctract > extract
    automationList = ['none',' load', 'exctract', 'select', 'start']

    # menu type
    menuType = 'auto'
    menuTypeList = ['text', 'gui', 'auto']

    # list of path to search for the configuration
    searchPaths = [
        '.mdf',
        'mdf',
        '.MDF',
        'MDF',
        '.rnel',
        'rnel',
        '.RNEL',
        'RNEL',
        'MATLAB',
        'Documents/MATLAB'
    ]

    # constructor
    def __init__(self, filename):
        """
        takes filename (which is path to xml file)
        """
        self.filename = filename

    def load(self):
        """
        calls the appropriate function to load the configuration data from the conf file (self.filename)
        - the equivalent to mMDF/core/@mdfConf/load
        - Not supporting the legacy config format however (TODO...?)
        """
        # first, read file as str
        with open(self.filename, 'r') as config_file:
            self.raw_file_str = config_file.read()

        try:
            self.__load_xml()
            self.fileType = "xml"
        except Exception as xml_error:
            try:
                self.__load_json()
                self.fileType = "json"
            except Exception as json_error:
                # not supporting legacy in python. Just throw error
                raise json_error

    def extract(self):
        """
        after loading the configuration file in, now we can extract the relevant fields out of the config file into mdfConf
        """
        if self.fileType == "xml":
            self.__extract_xml()
        elif self.fileType == "json":
            self.__extract_json()



    #######################
    # private methods
    #######################
    def __load_xml(self):
        self.parsed_file = BeautifulSoup(self.raw_file_str, "lxml-xml")

    def __load_json(self):
        self.parsed_file = json.loads(self.raw_file_str)

    def __extract_xml():
        pass
    def __extract_json():
        pass
