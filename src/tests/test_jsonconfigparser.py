import unittest 
from src import json_config_parser as c


class TestJsonConfigParser(unittest.TestCase):

    def test_get_file_path(self):
        conf = c.get_config('dev')
        print (conf)
        self.assertTrue(conf)


if __name__ == '__main__':
    unittest.main()
