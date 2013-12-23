import sys

from wsgiref.util import setup_testing_defaults
from wsgiref.simple_server import make_server

import backend_wsgi as backend

host = ""
port = 8080

# print help message and exit
def help():
  print "syntax: " + sys.argv[0] + " [[HOST]:[PORT]]"
  print "defaults to " + (host if host else "localhost") + ":" + str(port)
  sys.exit(1)
  pass

if "-h" in sys.argv or "--help" in sys.argv:
  help()
  pass

if len(sys.argv) > 1:
  try:
    hp = sys.argv[1].split(":", 1)
    port = int(hp[1]) if hp[1] else port
    host = hp[0] if hp[0] else host
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
