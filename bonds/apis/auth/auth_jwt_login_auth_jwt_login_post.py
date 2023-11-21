from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
class Body_auth_jwt_login_auth_jwt_login_post(BaseModel):
    client_id: typing.Optional[typing.Union[str, str]]  = None
    client_secret: typing.Optional[typing.Union[str, str]]  = None
    grant_type: typing.Optional[typing.Union[str, str]]  = None
    password: str 
    scope: str  = ''
    username: str 

class BearerResponse(BaseModel):
    access_token: str 
    token_type: str 

class ErrorModel(BaseModel):
    detail: typing.Union[str, typing.Dict[str, str]] 

class ValidationError(BaseModel):
    loc: typing.List[typing.Union[str, int]] 
    msg: str 
    type: str 

class HTTPValidationError(BaseModel):
    detail: typing.Optional[typing.List[ValidationError]]  = None

def make_request(self: BaseApi,

    __request__: Body_auth_jwt_login_auth_jwt_login_post,


) -> BearerResponse:
    """Auth:Jwt.Login"""

    
    body = __request__
    

    m = ApiRequest(
        method="POST",
        path="/auth/jwt/login".format(
            
        ),
        content_type="application/json",
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
            
                "application/json": BearerResponse,
            
        },
    
        "400": {
            
                "application/json": ErrorModel,
            
        },
    
        "422": {
            
                "application/json": HTTPValidationError,
            
        },
    
    }, m)