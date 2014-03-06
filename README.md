# Rack::MongoidAdapter
Provides RESTful interface for MongoDB as a rack middleware.

## Usage
Here is the simplest example for Heroku with MongoLab plugin.

### Operation
```
# settings
$ mkdir config
$ vi config/mongoid.yml
$ vi config.ru
$ vi Gemfile
$ bundle install
$ git init
$ git add .
$ git commit -m "Initial commit"
$ heroku create my-test-app
$ heroku addons:add mongolab
$ git push heroku master
```

### Code
```yaml
# config/mongoid.yml
development:
  sessions:
    default:
      database: default
      hosts:
        - localhost:27017

production:
  sessions:
    default:
      uri: <%= ENV["MONGOLAB_URI"] %>
```

```ruby
# config.ru
require "rack/mongoid_adapter"
run Rack::MongoidAdapter
```

```ruby
# Gemfile
source "https://rubygems.org"
gem "rack-mongoid_adapter"
```

### POST /{resource_type} - Create a new entry
```
$ curl http://my-test-app.herokuapp.com/entries -d "attributes[foo]=bar" -i
HTTP/1.1 201 Created
Date: Thu, 06 Mar 2014 14:55:23 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-02-24)
Content-Length: 46
Connection: keep-alive

{"foo":"bar","_id":"53188c5b3536340002000000"}
```

### GET /{resource_type} - Get all entries
```
$ curl http://my-test-app.herokuapp.com/entries -i
HTTP/1.1 200 OK
Date: Thu, 06 Mar 2014 14:56:33 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-02-24)
Content-Length: 48
Connection: keep-alive

[{"foo":"bar","_id":"53188c5b3536340002000000"}]
```

### GET /{resource_type}/{id} - Get the entry
```
$ curl http://my-test-app.herokuapp.com/entries/53188c5b3536340002000000 -i
HTTP/1.1 200 OK
Date: Thu, 06 Mar 2014 14:57:35 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-02-24)
Content-Length: 46
Connection: keep-alive

{"foo":"bar","_id":"53188c5b3536340002000000"}
```

### PUT /{resource_type}/{id} - Update the entry
```
$ curl http://my-test-app.herokuapp.com/entries/53188c5b3536340002000000 -X PUT -d "attributes[foo]=baz" -i
HTTP/1.1 204 No Content
Date: Thu, 06 Mar 2014 14:59:04 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-02-24)
Connection: keep-alive
```

### DELETE /{resource_type}/{id} - Delete the entry
```
$ curl http://my-test-app.herokuapp.com/entries/53188c5b3536340002000000 -X DELETE -i
HTTP/1.1 204 No Content
Date: Thu, 06 Mar 2014 14:59:50 GMT
Server: WEBrick/1.3.1 (Ruby/2.0.0/2014-02-24)
Connection: keep-alive
```
