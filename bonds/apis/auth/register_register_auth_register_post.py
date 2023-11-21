from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
class UserCreate(BaseModel):
    email: str 
    is_active: typing.Union[bool, str]  = True
    is_superuser: typing.Union[bool, str]  = False
    is_verified: typing.Union[bool, str]  = False
    password: str 
    role_id: int 
    username: str 

class UserRead(BaseModel):
    email: str 
    id: int 
    is_active: bool  = True
    is_superuser: bool  = False
    is_verified: bool  = False
    role_id: int 
    username: str 

class ErrorModel(BaseModel):
    detail: typing.Union[str, typing.Dict[str, str]] 

class ValidationError(BaseModel):
    loc: typing.List[typing.Union[str, int]] 
    msg: str 
    type: str 

class HTTPValidationError(BaseModel):
    detail: typing.Optional[typing.List[ValidationError]]  = None

def make_request(self: BaseApi,

    __request__: UserCreate,


) -> UserRead:
    """Register:Register"""

    
    body = __request__
    

    m = ApiRequest(
        method="POST",
        path="/auth/register".format(
            
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
    
        "201": {
            
                "application/json": UserRead,
            
        },
    
        "400": {
            
                "application/json": ErrorModel,
            
        },
    
        "422": {
            
                "application/json": HTTPValidationError,
            
        },
    
    }, m)