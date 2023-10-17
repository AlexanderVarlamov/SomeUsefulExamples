from http.server import HTTPServer, CGIHTTPRequestHandler


def run(server_class=HTTPServer, handler_class=CGIHTTPRequestHandler):
    server_address = ('localhost', 8000)
    httpd = server_class(server_address, handler_class)
    httpd.serve_forever()


run()
