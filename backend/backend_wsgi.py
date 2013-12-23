import json

db = None # global

def loaddb(dblocat="backend.json"):
  global db

  try:
    with open(dblocat, "r") as f:
      db = json.load(f)
      pass
  except:
    db = {}
    pass
  return

def writedb(dblocat="backend.json"):
  global db
  if not db:
    return False

  with open(dblocat, "w") as f:
    json.dump(db, f)
    pass
  return True

def sanitize_path(path):
  newpath = path.split("/")
  newpath = filter(lambda x: x != "", newpath)
  return "/" + "/".join(newpath)

def bad_request(start_response, errorstr):
  start_response("400 Bad Request", [("content-type", "text/plain")])
  return errorstr

def services(start_response):
  global db
  if not db:
    loaddb()
    pass

  start_response("200 OK",
                 [("content-type", "application/json; charset=utf-8")])
  return json.dumps(db)

def add_service(env, start_response):
  global db

  try:
    rawdata = env["wsgi.input"].read(int(env["CONTENT_LENGTH"]))
    datadict = json.loads(rawdata)

    if not db:
      loaddb()
      pass

    db[datadict["url"]] = \
        { "name" : datadict["name"], "description" : datadict["description"] }
    start_response("200 OK",
                   [("content-type", "application/json; charset=utf-8")])
    writedb()
    return json.dumps({ "url" : datadict["url"],
                        "name" : datadict["name"],
                        "description" : datadict["description"] })
  except:
    return bad_request(start_response, "Malformed service add attempt!\r\n")
  pass

def application(env, start_response):
  method = env["REQUEST_METHOD"].upper()
  page = sanitize_path(env["PATH_INFO"])

  if method == "GET" and page == "/services":
    return services(start_response)
  elif method == "POST" and page == "/services/new":
    return add_service(env, start_response)

  return bad_request(start_response,
                     "Interesting content all at /services\r\n")
