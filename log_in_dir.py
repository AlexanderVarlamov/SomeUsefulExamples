"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 13.07.2023
@time 15:24
"""
import logging
import os
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path

SELF_DIR_PATH = Path(__file__).parent.absolute()
DAYS_TO_KEEP_LOGS = 3
LOG_LEVEL = 'INFO'


def get_current_log_filename():
    current_date = datetime.now().strftime('%d_%m_%Y')
    return current_date + '_project_job.log'


def get_logger(filename):
    logger = logging.getLogger("run_datastage_job")
    logger.setLevel(LOG_LEVEL)
    handler_stdout = logging.StreamHandler(sys.stdout)
    handler_file = logging.FileHandler(f"{SELF_DIR_PATH}{os.sep}{filename}", encoding="utf-8", mode="a")

    logger.addHandler(handler_stdout)
    logger.addHandler(handler_file)

    return logger


def check_if_file_too_old(path):
    now = datetime.now()
    file_created = datetime.fromtimestamp(os.path.getmtime(path))
    diff = now - file_created
    return diff > timedelta(seconds=10)


def delete_old_logs(logger):
    list_of_existing_logs = [item for item in os.listdir(SELF_DIR_PATH) if item[-4:] == '.log']
    logger.debug(f"List of all logs: {list_of_existing_logs}")
    list_of_files_to_delete = [item for item in list_of_existing_logs if check_if_file_too_old(item)]
    logger.info(f"List of old logs: {list_of_files_to_delete}")
    for file in list_of_files_to_delete:
        try:
            logger.info(f"Trying to delete {file}")
            os.remove(file)
            logger.info(f" {file} is deleted successfully")

        except Exception as e:
            logger.info(f"Unable to delete {file}")
            logger.info(e)


if __name__ == '__main__':
    current_file = get_current_log_filename()
    logger = get_logger(current_file)
    logger.info("-"*30)
    logger.info(datetime.now())
    logger.info(f"Starting new job. Args are {sys.argv}")
    time.sleep(5)
    delete_old_logs(logger)
    logger.info(f"Job ended at {datetime.now()}")
    logger.info("-" * 30)
    logger.info('')