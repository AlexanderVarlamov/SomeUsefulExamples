"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 20.07.2023
@time 11:03
"""

import logging

import requests as requests
import unicodedata
from aiogram import Bot, Dispatcher, types
from aiogram.types import ParseMode
from aiogram.utils import executor

API_TOKEN = '6269958264:AAEdScLrCgcphW2G16PbUjnqbmGe-kdRWU8'

# Configure logging
logging.basicConfig(level=logging.INFO)

# Initialize bot and dispatcher
bot = Bot(token=API_TOKEN)
dp = Dispatcher(bot)


@dp.message_handler(commands=['start', 'help'])
async def send_welcome(message: types.Message):
    """
    This handler will be called when user sends `/start` or `/help` command
    """
    msg = """
Привет! Это бот для агрегации последних новостей
Допустимые опции:
    /all Новости из всех источников
    /rambler Новости Рамблер
    /lenta Новости Лента.ру
    /news_ru Новости News.ru"""
    await message.answer(msg)


def get_news_url(title, url):
    return f'<a href="{url}">{title}\n</a>'


def normalize_json(lst: list[dict]) -> list[dict]:
    for source in lst:
        for key in source.keys():
            inner_list = source[key]
            new_inner_list = [[unicodedata.normalize('NFKC', item[0]), item[1]] for item in inner_list]
            new_inner_list = [get_news_url(item[0], item[1]) for item in new_inner_list]
            source[key] = new_inner_list
    return lst


@dp.message_handler(commands=['all'])
async def get_all_news(message: types.Message):
    """
    This handler will be called when user sends `/all
    """
    url = 'http://127.0.0.1:5008/getnews_raw'
    news = requests.post(url, json={"sources": ['all']})
    raw_json: dict = news.json()['news']
    pretty_jsn = normalize_json(raw_json)
    for source in pretty_jsn:
        for key in source.keys():
            inner_list = source[key]
            await message.answer('\n'.join(inner_list), parse_mode=ParseMode.HTML)


@dp.message_handler(commands=['rambler'])
async def get_all_news(message: types.Message):
    """
    This handler will be called when user sends `/rambler
    """
    url = 'http://127.0.0.1:5008/getnews_raw'
    news = requests.post(url, json={"sources": ['rambler']})
    raw_json: dict = news.json()['news']
    pretty_jsn = normalize_json(raw_json)
    for source in pretty_jsn:
        for key in source.keys():
            inner_list = source[key]
            await message.answer('\n'.join(inner_list), parse_mode=ParseMode.HTML)


@dp.message_handler(commands=['news_ru'])
async def get_all_news(message: types.Message):
    """
    This handler will be called when user sends `/rambler
    """
    url = 'http://127.0.0.1:5008/getnews_raw'
    news = requests.post(url, json={"sources": ['news_ru']})
    raw_json: dict = news.json()['news']
    pretty_jsn = normalize_json(raw_json)
    for source in pretty_jsn:
        for key in source.keys():
            inner_list = source[key]
            await message.answer('\n'.join(inner_list), parse_mode=ParseMode.HTML)


@dp.message_handler(commands=['news_ru'])
async def get_all_news(message: types.Message):
    """
    This handler will be called when user sends `/news_ru
    """
    url = 'http://127.0.0.1:5008/getnews_raw'
    news = requests.post(url, json={"sources": ['news_ru']})
    raw_json: dict = news.json()['news']
    pretty_jsn = normalize_json(raw_json)
    for source in pretty_jsn:
        for key in source.keys():
            inner_list = source[key]
            await message.answer('\n'.join(inner_list), parse_mode=ParseMode.HTML)


@dp.message_handler(commands=['lenta'])
async def get_all_news(message: types.Message):
    """
    This handler will be called when user sends `/lenta
    """
    url = 'http://127.0.0.1:5008/getnews_raw'
    news = requests.post(url, json={"sources": ['lenta_ru']})
    raw_json: dict = news.json()['news']
    pretty_jsn = normalize_json(raw_json)
    for source in pretty_jsn:
        for key in source.keys():
            inner_list = source[key]
            await message.answer('\n'.join(inner_list), parse_mode=ParseMode.HTML)


if __name__ == '__main__':
    executor.start_polling(dp, skip_updates=True)
