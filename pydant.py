"""
version
@author varlamov.a
@email varlamov.a@rt.ru
@date 23.05.2023
@time 17:02
"""

import logging
import time
import sys
logger = logging.getLogger("test_logger")
logger.setLevel("INFO")
logger.addHandler(logging.StreamHandler(sys.stdout))
from subprocess import run, PIPE



def run_bash_and_get_result(cmd: str):
    running_script = run(cmd.split(), capture_output=True)
    bash_output = running_script.stdout.decode()
    run_result = running_script.returncode

    logger.info(f"cmd={cmd}")
    logger.info(f"run_result={run_result}")
    logger.info(f"bash_output={bash_output}")

    return run_result, bash_output


run_bash_and_get_result("ls -la")