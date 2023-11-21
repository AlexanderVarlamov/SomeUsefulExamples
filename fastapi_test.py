"""
version 
@author varlamov.a
@email varlamov.a@rt.ru
@date 07.11.2023
@time 11:14
"""
import asyncio

import aiohttp
import requests

url = "http://127.0.0.1:8000/protected-route"
auth_url = "http://127.0.0.1:8000/auth/jwt/login"
auth_data = {"username": "qw@er.ty", "password": "123"}

s = requests.Session()


# with requests.Session() as s:
#     req1 = s.post(url=auth_url, data=auth_data)
#     print(req1.status_code)
#     token = req1.json().get("access_token")
#     print(token)
#     print(s.headers)
#     s.headers["Authorization"] = f'Bearer {token}'
#     req = s.get(url=url)
#     print(req.status_code)
#     print(req.text)

import jwt
SECRET = "qwerty123"

async def get_xml():
    print("асинхронный вариант")
    async with aiohttp.ClientSession() as s:
        async with s.post(url=auth_url, data=auth_data) as r:
            jsn = await r.json()
            token = jsn.get("access_token")
            s.headers["Authorization"] = f'Bearer {token}'
        for _ in range(5):
            async with s.get(url=url) as r:
                cont = await r.text()
                print(cont)
        print(token)

        # верификация
        await asyncio.sleep(4)
        payload = jwt.decode(token, SECRET, algorithms=["HS256"], audience="frontend")
        print(payload)


asyncio.run(get_xml())
