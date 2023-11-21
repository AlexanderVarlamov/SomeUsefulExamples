from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
class ValidationError(BaseModel):
    loc: typing.List[typing.Union[str, int]] 
    msg: str 
    type: str 

class HTTPValidationError(BaseModel):
    detail: typing.Optional[typing.List[ValidationError]]  = None

def make_request(self: BaseApi,


    operation_type: str,

) -> None:
    """Get Specific Operations"""

    
    body = None
    

    m = ApiRequest(
        method="GET",
        path="/operations/".format(
            
        ),
        content_type=None,
        body=body,
        headers=self._only_provided({
        }),
        query_params=self._only_provided({
                "operation_type": operation_type,
            
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