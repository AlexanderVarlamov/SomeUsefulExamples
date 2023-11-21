from dataclasses import dataclass
from swagger_codegen.api.client import ApiClient
from swagger_codegen.api.configuration import Configuration
from swagger_codegen.api.adapter.base import HttpClientAdapter


from .apis.auth.api import AuthApi

from .apis.operation.api import OperationApi

from .apis.api.api import ApiApi



@dataclass
class AutogeneratedApiClient:
    configuration: Configuration
    client: ApiClient
    auth: AuthApi
    operation: OperationApi
    api: ApiApi


def new_client(
    adapter: HttpClientAdapter, configuration: Configuration
) -> AutogeneratedApiClient:
    client = ApiClient(configuration=configuration, adapter=adapter)
    return AutogeneratedApiClient(
        configuration,
        client=client,
        
        auth=AuthApi(client, configuration),
        
        operation=OperationApi(client, configuration),
        
        api=ApiApi(client, configuration)
        
    )