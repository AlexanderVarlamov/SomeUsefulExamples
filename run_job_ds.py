"""
version 0.01
@author varlamov.a
@email varlamov.a@rt.ru
@date 13.07.2023
@time 10:29
"""
import logging
import os
import sys
import time
from datetime import datetime, timedelta
from pathlib import Path
from subprocess import run, STDOUT, PIPE

SELF_DIR_PATH = Path(__file__).parent.absolute()
DAYS_TO_KEEP_LOGS = 3
LOG_LEVEL = 'DEBUG'

DSHOME = "$DSHOME"
DSJOBPATH = "$DSHOME/bin/"

PROJECT = sys.argv[1]
DSJOB = sys.argv[2]
PARAMS = sys.argv[3]
SET_PARAMS = ' '.join(sys.argv[3:])
JOB_STATUS_STRING = f'{DSJOBPATH}dsjob -jobinfo {PROJECT} {DSJOB} | head -1 | cut -d"(" -f2 | cut -d")" -f1'
JOB_RUN_STRING = f'{DSJOBPATH}dsjob -run -mode NORMAL {SET_PARAMS} {PROJECT} {DSJOB}'

STATUSES = {
    1: lambda val: "job completed successfully",
    2: lambda val: "job completed successfully",
    0: lambda val: f"Error: {DSJOB} job failed. Error code was -ALREADY RUNNING- Code {val}",
    3: lambda val: f"Error: {DSJOB} job failed. Error code was -ABORT- Code {val}",
    96: lambda val: f"Error: {DSJOB} job failed. Error code was -ABORT- Code {val}",
    8: lambda val: f"Error: {DSJOB} job failed. Error code was -Failed Validation- Code {val}",
    13: lambda val: f"Error: {DSJOB} job failed. Error code was -Failed Validation- Code {val}",
    97: lambda val: f"Error: {DSJOB} job failed. Error code was -Stopped- Code {val}",
    9: lambda val: f"Error: {DSJOB} job failed. Error code was -Not Compiled- Code {val}",
}


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
    return diff > timedelta(days=DAYS_TO_KEEP_LOGS)


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


def run_bash_and_get_result(cmd: str, logger):
    running_script = run(cmd, stdout=PIPE, stderr=STDOUT, shell=True)
    bash_output = running_script.stdout.decode(encoding='utf-8')
    run_result = running_script.returncode

    logger.debug(f"cmd={cmd}")
    logger.info(f"run_result={run_result}")
    logger.debug(f"bash_output={bash_output}")

    return run_result, bash_output


def run_environment(logger):
    print(f'source {DSHOME}dsenv')
    run_bash_and_get_result(f'source {DSHOME}dsenv', logger)


def get_job_status(cmd: str, logger):
    _, bash_output = run_bash_and_get_result(cmd, logger)
    logger.info(f'Before run JOB_STATUS={bash_output}')
    return bash_output


def run_the_job(cmd: str, logger):
    logger.info(cmd)
    return run_bash_and_get_result(cmd, logger)


def check_job_status_before_run(job_status: int, logger):
    if job_status == 0:
        logger.info(f"Job {DSJOB} already running")
        sys.exit(1)
    elif job_status in [1, 2, 7, 9, 11, 12, 21, 99]:
        return
    elif job_status not in [1, 2, 7, 9, 11, 12, 21, 99]:
        reset_string = f'{DSJOBPATH}dsjob -run -mode RESET -wait {PROJECT} {DSJOB}'
        logger.info(reset_string)
        result_of_reset, _ = run_bash_and_get_result(reset_string, logger)
        if result_of_reset != 0:
            logger.info(f"Unable to reset job. {DSJOB} is already running.")
            sys.exit(result_of_reset)


def process_result(res, logger):
    log_func = STATUSES.get(res, lambda val: f"Error: {DSJOB} job failed. Error code was {val}")
    logger.info(log_func(res))


if __name__ == '__main__':
    current_file = get_current_log_filename()
    logger = get_logger(current_file)

    logger.info("-" * 30)
    logger.info(datetime.now())
    logger.info(f"Starting new job. Args are {sys.argv}")
    delete_old_logs(logger)

    run_environment(logger)
    job_status = int(get_job_status(JOB_STATUS_STRING, logger))
    check_job_status_before_run(job_status, logger)
    _, result_of_job = run_the_job(JOB_RUN_STRING, logger)
    print(result_of_job)
    time.sleep(5)
    process_result(int(get_job_status(JOB_STATUS_STRING, logger)), logger)

    logger.info(f"Job ended at {datetime.now()}")
    logger.info("-" * 30)
    logger.info('')
