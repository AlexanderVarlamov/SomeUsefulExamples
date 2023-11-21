from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
def make_request(self: BaseApi,


) -> None:
    """Auth:Jwt.Logout"""

    
    body = None
    

    m = ApiRequest(
        method="POST",
        path="/auth/jwt/logout".format(
            
        ),
        content_type=None,
        body=body,
        headers=self._only_provided({
        }),
        query_params=self._only_provided({
        }),
        cookies=self._only_provided({
        }),
    )
    return self.make_request({
    
        "200": {
            
                "application/json": None,
            
        },
    
        "401": {
            
                "default": None,
            
        },
    
    }, m)