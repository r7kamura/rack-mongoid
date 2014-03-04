# Rack::MongoidAdapter
Provides RESTful interface as a rack application, wrapping MongoDB.

## Usage
```ruby
# config.ru
run Rack::MongoidAdapter.new
```

## API
* GET /:resource_type
* GET /:resource_type/:id
* POST /:resource_type
* PUT /:resource_type/:id
* DELETE /:resource_type/:id
