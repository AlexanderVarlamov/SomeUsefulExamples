from __future__ import annotations

from swagger_codegen.api.base import BaseApi

from . import get_specific_operations_operations__get
from . import add_specific_operations_operations__post
from . import get_long_op_operations_long_operation_get
class OperationApi(BaseApi):
    get_specific_operations_operations__get = get_specific_operations_operations__get.make_request
    add_specific_operations_operations__post = add_specific_operations_operations__post.make_request
    get_long_op_operations_long_operation_get = get_long_op_operations_long_operation_get.make_request