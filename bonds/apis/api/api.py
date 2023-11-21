from __future__ import annotations

from swagger_codegen.api.base import BaseApi

from . import protected_route_protected_route_get
from . import get_dashboard_report_report_dashboard_get
from . import unprotected_route_unprotected_route_get
class ApiApi(BaseApi):
    protected_route_protected_route_get = protected_route_protected_route_get.make_request
    get_dashboard_report_report_dashboard_get = get_dashboard_report_report_dashboard_get.make_request
    unprotected_route_unprotected_route_get = unprotected_route_unprotected_route_get.make_request