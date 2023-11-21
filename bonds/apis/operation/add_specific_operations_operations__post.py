from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
class OperationCreate(BaseModel):
    date: datetime.datetime 
    figi: str 
    id: int 
    instrument_type: str 
    quantity: str 
    type: str 

class ValidationError(BaseModel):
    loc: typing.List[typing.Union[str, int]] 
    msg: str 
    type: str 

class HTTPValidationError(BaseModel):
    detail: typing.Optional[typing.List[ValidationError]]  = None

def make_request(self: BaseApi,

    __request__: OperationCreate,


) -> None:
    """Add Specific Operations"""

    
    body = __request__
    

    m = ApiRequest(
        method="POST",
        path="/operations/".format(
            
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
            
                "application/json": None,
            
        },
    
        "422": {
            
                "application/json": HTTPValidationError,
            
        },
    
    }, m)