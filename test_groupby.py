"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 13.06.2023
@time 10:46
"""
import logging
import sys
from collections import namedtuple
from itertools import groupby
import psycopg2

con = psycopg2.connect(host='localhost', port=5432, user='postgres', password='123', database='sql_practice')


with con.cursor() as cur:
    cur.execute("""
                    select message_id ,
                    message_header ,
                    message_body,
                    message_channel,
                    user_address,
                    full_attachment_name from message_queue
	"""
            )
    desc = cur.description
    res = cur.fetchall()

res = sorted(res, key=lambda x: (x[0], x[1], x[2], x[3]))

grouped_messages = []

for key, group_items in groupby(res, key=lambda x: (x[0], x[1], x[2], x[3])):
    email_list = []
    attach_list = []

    for item in group_items:
        email_list.append(item[4])
        attach_list.append(item[5])

    line_to_append = list(key) + [email_list, attach_list]
    grouped_messages.append(line_to_append)

print(grouped_messages)

sql_script = 'select ' \
             'message_id, message_header, message_body, message_channel, user_address, full_attachment_name ' \
             'from v_ntf_queue'

print(sql_script)

log_level = logging.INFO
logger = logging.getLogger("notification_dag")
logger.setLevel(log_level)
logger.addHandler(logging.StreamHandler(sys.stdout))
[logger.info(str(message)) for message in grouped_messages]
