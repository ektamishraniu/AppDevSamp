import random


def slices(s):
    x,y = random.random(), random.random()
    print ("Worker is running!")
    return x*x, + y*y < 1


def calculate_pi(spark):
    samples = 20
    count = spark.sparkContext.parallelize(range(0, samples)).filter(slice).count()
    print("Pi is %f" % (4.0 * count/samples))
