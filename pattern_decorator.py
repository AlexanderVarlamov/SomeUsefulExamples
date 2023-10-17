import sys
from subprocess import run, PIPE

string = "python D:\pyth_project\pythonProject1\\test_sp.py"
arr=string.split()

running_script_result = run(arr, stdout=PIPE)

bash_output = running_script_result.stdout.decode()
print(bash_output)
print(f"result is {running_script_result.returncode}")

from collections import namedtuple
check_task = namedtuple("check_task", "checkset_id, checktask_id, py_cmd, pool_num, job_name")


def create_checktask_from_tuple(item: tuple) -> check_task:
    assert type(item) == tuple
    assert len(item) == 5
    return check_task(
        checkset_id=item[0],
        checktask_id=item[1],
        py_cmd=item[2],
        pool_num=item[3],
        job_name=item[4]
    )


item_from_list = (66964,
                  2438053,
                  '/opt/venv36/bin/python /DataStage/InformationServer/Server/Projects/SDEV_DQ/SH_SCRIPTS/edw_dq/run_checktask.py -cht_id 2438053',
                  1,
                  'job_name'
                  )

xxx = create_checktask_from_tuple(item_from_list)
print(xxx)

xx= [x+2 for x in range(3)]
print(type(xx))
