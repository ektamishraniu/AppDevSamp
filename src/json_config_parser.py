import json
import os
import argparse
from pkg_resources import resource_stream

def load_config_json(nenv):
    with resource_stream(__name__, 'config/{0}.json'.format(nenv)) as config_file:
        data = config_file.read()
        config_data = json.loads(data.decode('utf-8'))
    return config_data

def get_config(env):
    config_data = load_config_json(env)
    return config_data

