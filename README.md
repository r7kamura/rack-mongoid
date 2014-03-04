# Rack::MongoidAdapter
Provides RESTful interface for MongoDB as a rack application.

## Usage
```ruby
# config.ru
run Rack::MongoidAdapter.new
```

## API
| Name    | Verb   | Path        | MongoDB                                 |
| ---     | ---    | ---         | ---                                     |
| Index   | GET    | /foobar     | db.foobar.find                          |
| Show    | GET    | /foobar/:id | db.foobar.find(_id: id)                 |
| Create  | POST   | /foobar     | db.foobar.insert(params)                |
| Update  | PUT    | /foobar/:id | db.foobar.update(_id: id, $set: params) |
| Destroy | DELETE | /foobar/:id | db.foobar.remove(_id: id)               |
