from pyspark.sql import SparkSession
import argparse
from src import json_config_parser as c
from src import sample_python as sp
from src import sample_spark as ss
from src import log

logger = log.setupLogger('root')

def main(config, debug):
    print("Your ekta code..")

    log.setLevel(logger, debug)
    
    ##For counting dataframe use log.debugCount/ and for print dataframe use log.debugShow  
    ##The functions make sure these statements are not executed in prod. 

    spark = get_spark()
    sp.split_array()
    ss.calculate_pi(spark)

def get_spark():
    spark = SparkSession.builder.appName("Sample spark app").getOrCreate()
    return spark

if __name__ == '__main__':
    print("Starting to run project_name ...")
    parser = argparse.ArgumentParser()
    parser.add_argument('-env')
    parser_elements = vars(parser.parse_args())

    if parser_elements['env'] is not None:
        env = parser_elements['env']
    else:
        env = 'prod'
    
    if env is 'prod':
        debug = False
    else :
        debug = True

    config = c.get_config(env)

    main(config, debug)
