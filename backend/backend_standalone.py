import sys

from wsgiref.util import setup_testing_defaults
from wsgiref.simple_server import make_server

import backend_wsgi as backend

def help():
  print "syntax: " + sys.argv[0] + " [[HOST]:[PORT]]"
  print "defaults to port 8080 and host \"\""
  sys.exit(1)
  pass

host = ""
port = 8080

if "-h" in sys.argv or "--help" in sys.argv:
  help()
  pass

if len(sys.argv) > 1:
  try:
    hp = sys.argv[1].split(":", 1)
    host = hp[0] if hp[0] else host
    port = int(hp[1]) if hp[1] else port
    pass
  except:
    help()
    pass
  pass

if port < 0 or port > 65535:
  help()
  pass

print "starting on " + (host if host else "localhost") + " port " + str(port)
httpd = make_server(host, port, backend.application)
print "serving..."
httpd.serve_forever()
