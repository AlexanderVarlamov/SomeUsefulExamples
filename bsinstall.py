from urllib.request import urlopen, urlretrieve
from bs4 import BeautifulSoup
#import html5lib


resp = urlopen('https://stackoverflow.com/questions/22696961/beautifulsoup-lxml-and-html5lib-parsers-scraping-differences')  # скачиваем файл
html = resp.read().decode('utf8')  # считываем содержимое
soup = BeautifulSoup(html, 'html.parser')  # делаем суп
res = 0
print(soup.get_text())

