from __future__ import annotations

import datetime
import pydantic
import typing

from pydantic import BaseModel

from swagger_codegen.api.base import BaseApi
from swagger_codegen.api.request import ApiRequest
from swagger_codegen.api import json
class Body_verify_request_token_auth_request_verify_token_post(BaseModel):
    email: str 

class ValidationError(BaseModel):
    loc: typing.List[typing.Union[str, int]] 
    msg: str 
    type: str 

class HTTPValidationError(BaseModel):
    detail: typing.Optional[typing.List[ValidationError]]  = None

def make_request(self: BaseApi,

    __request__: Body_verify_request_token_auth_request_verify_token_post,


) -> None:
    """Verify:Request-Token"""

    
    body = __request__
    

    m = ApiRequest(
        method="POST",
        path="/auth/request-verify-token".format(
            
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
    
        "202": {
            
                "application/json": None,
            
        },
    
        "422": {
            
                "application/json": HTTPValidationError,
            
        },
    
    }, m)