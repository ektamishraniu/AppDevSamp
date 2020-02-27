import unittest
import os, sys
sys.path.append(os.path.dirname(os.path.dirname(os.path.abspath(__file__))))
from src import sample_python as sp


class TestSampleCode(unittest.TestCase):
    def test_upper(self):
        self.assertEqual('foo'.upper(), 'FOO')

    def test_split_array(self):
        sp.split_array()


if __name__ == '__main__':
    unittest.main()
