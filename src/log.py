
import logging


def setupLogger(name):
    formatter = logging.Formatter(fmt='%(asctime)s - %(levelname)s - %(module)s - %(message)s')

    handler = logging.StreamHandler()
    handler.setFormatter(formatter)

    logger = logging.getLogger(name)

    logger.addHandler(handler)

    return logger


def setLevel(logger, debug):
    if debug is True:
        logger.setLevel(logging.DEBUG)
    else:
        logger.setLevel(logging.INFO)


def debugCount(logger, df, msg):
    if(logger.isEnabledFor(logging.DEBUG)):
        msg = msg + ', %s'
        logger.debug(msg, df.count())

def debugShow(logger, df, num=0):
    if(logger.isEnabledFor(logging.DEBUG)):
        if num > 0:
            logger.debug(df.show(num))
        else:
            logger.debug(df.show())
