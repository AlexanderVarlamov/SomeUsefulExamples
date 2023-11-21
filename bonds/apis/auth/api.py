from __future__ import annotations

from swagger_codegen.api.base import BaseApi

from . import auth_jwt_login_auth_jwt_login_post
from . import auth_jwt_logout_auth_jwt_logout_post
from . import register_register_auth_register_post
from . import verify_request_token_auth_request_verify_token_post
from . import verify_verify_auth_verify_post
class AuthApi(BaseApi):
    auth_jwt_login_auth_jwt_login_post = auth_jwt_login_auth_jwt_login_post.make_request
    auth_jwt_logout_auth_jwt_logout_post = auth_jwt_logout_auth_jwt_logout_post.make_request
    register_register_auth_register_post = register_register_auth_register_post.make_request
    verify_request_token_auth_request_verify_token_post = verify_request_token_auth_request_verify_token_post.make_request
    verify_verify_auth_verify_post = verify_verify_auth_verify_post.make_request