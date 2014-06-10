# Rack::Mongoid
Provides RESTful interface for MongoDB as a rack middleware.

## Usage
```yaml
# config/mongoid.yml
production:
  sessions:
    default:
      uri: <%= ENV["MONGOLAB_URI"] %>
```

```ruby
# config.ru
require "rack/mongoid"
run Rack::Mongoid
```

```ruby
# Gemfile
source "https://rubygems.org"
gem "rack-mongoid"
```

### POST /{resource_name} - Create a new resource
```sh
$ curl http://my-example-app.herokuapp.com/users -d '{"name":"alice"}' -H "Content-Type: application/json" -i
HTTP/1.1 201 Created
Content-Type: application/json
Date: Tue, 10 Jun 2014 16:47:26 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-05-08)
Content-Length: 59
Connection: keep-alive

{
  "name": "alice",
  "_id": "5397369e3061380002010000"
}
```

### GET /{resource_name} - List resources
```sh
$ curl http://my-example-app.herokuapp.com/users -i
HTTP/1.1 200 OK
Content-Type: application/json
Date: Tue, 10 Jun 2014 16:48:19 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-05-08)
Content-Length: 109
Connection: keep-alive

[
  {"name":"alice","_id":"5397369e3061380002010000"}
]
```

### GET /{resource_name}/{id} - Show the resource
```sh
$ curl http://my-example-app.herokuapp.com/users/5397369e3061380002010000 -i
HTTP/1.1 200 OK
Content-Type: application/json
Date: Tue, 10 Jun 2014 16:48:48 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-05-08)
Content-Length: 55
Connection: keep-alive

{"name":"alice","_id":"5397369e3061380002010000"}
```

### PATCH /{resource_name}/{id} - Update the resource
```sh
$ curl http://my-example-app.herokuapp.com/users/5397369e3061380002010000 -X PATCH -d '{"name":"bob"}' -H "Content-Type: application/json" -i
HTTP/1.1 200 OK
Content-Type: application/json
Date: Tue, 10 Jun 2014 16:50:15 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-05-08)
Content-Length: 48
Connection: keep-alive

{"name":"bob","_id":"5397369e3061380002010000"}
```

### DELETE /{resource_name}/{id} - Delete the resource
```sh
$ curl http://my-example-app.herokuapp.com/users/5397369e3061380002010000 -X DELETE -i
HTTP/1.1 200 OK
Content-Type: application/json
Date: Tue, 10 Jun 2014 16:50:47 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-05-08)
Content-Length: 48
Connection: keep-alive

{"name":"bob","_id":"5397369e3061380002010000"}
```
