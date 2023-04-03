from urllib.request import urlopen
import re
from collections import Counter

html: str = urlopen('https://stepik.org/media/attachments/lesson/209719/2.html').read().decode('utf-8')

regex_to_find = r"<code>(.+?)<\/code>"

results = re.findall(regex_to_find, html)
cnt = Counter(results)
max_repeats = cnt.most_common(1)[0][1]

filtered = list(filter(lambda x: cnt[x] == max_repeats, cnt))
print(" ".join(filtered))
