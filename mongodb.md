name: section
layout: true
class: center, middle, inverse

---

name: content
layout: true
class: top, left

---

template: section
# NoSql

---

template: content
# NoSql: Not Only Sequel
.todo.center[IMAGE]

---

template: content
# NoSql: Persistence it's a service concern
* You don't have to choose a "one size fits all" solution
* You can choose what's best for your data (aka specialized data storage)
.todo.center[IMAGE]

---

template: section
# MongoDB

---

template: content
# MongoDB: Document Oriented Database
```json
{
  "_id" : ObjectId("56669d14be2e0c48d102444c"),
  "address" : {
    "building" : "1007",
    "coord" : [-73.856077, 40.848447],
    "street" : "Morris Park Ave",
    "zipcode" : "10462"
  },
  "borough" : "Bronx",
  "cuisine" : "Bakery",
  "grades" : [
    {
      "date" : ISODate("2014-03-03T00:00:00Z"),
      "grade" : "A",
      "score" : 2
    },
    {
      "date" : ISODate("2013-09-11T00:00:00Z"),
      "grade" : "A",
      "score" : 6
    }
  ],
  "name" : "Morris Park Bake Shop",
  "restaurant_id" : "30075445"
}
```

---

template: content
# MongoDB: Terminology

.half-left[
## RDBMS
* Database
* Table
* Row
* Index
* Join
* Foreign Key
* Partition
]

.half-right[
## MongoDB
* **Database**
* **Collection**
* **Document**
* **Index**
* **Embedded**
* **Reference**
* **Shard**
]

---

template: content
# MongoDB: Data Types (JSON/BSON)
* Double
* String
* Object
* Array
* Binary Data
* Object ID
* Boolean
* Date
* Null
* Regular Expression
* JavaScript
* JavaScript (with scope)
* Symbol
* 32-bit integer
* 64-bit integer
* Timestamp

---

template: content
# MongoDB: ObjectId

ObjectId is a 12-byte BSON type, constructed using:

* 4-byte timestamp
* 3-byte machine identifier
* 2-byte process id
* 3-byte counter, starting with a random value

In MongoDB, documents stored in a collection require a unique `_id` field that acts as a primary key. MongoDB uses `ObjectId` as the default value for the `_id` field if the `_id` field is not specified the MongoDB driver adds the `_id` field that holds an `ObjectId`. In addition, if the `mongod` receives a document to insert that does not contain an `_id` field, `mongod` will add the `_id` field that holds an `ObjectId`.

---

template: content
# MongoDB: Why? Flexible Data Model

```json
{
  "name": "Gabriele",
  "surname": "Lana",
  "email": "gabriele.lana@gmail.com"
}
```

> What if we need to store more than one email per user?

```json
{
  "name": "Gabriele",
  "surname": "Lana",
  "email": [
    "gabriele.lana@gmail.com",
    "gabriele.lana@cleancode.it"
  ]
}
```

---

template: content
# MongoDB: Flexible Data Model
* The *"schema"* is enforced by the application
* Collections can contain different *"types"* of documents but in practice they are pretty uniform
* It's gold at the beginning of the project when the *"schema"* is changing frequently (rapid prototyping)
* You still need migrations but much less
* Essential when your document grows in their lifetime (ex. Orders)

---

template: content
# MongoDB: Why? Where does it shine?
* Agile development
* Object oriented programming
* Event sourcing
* High performance on mixed workloads
* Scaling on demand
* High availability and auto failover
* Flexible schema ans secondary indexes
* Data driven organizations (prototypes)
* Commodity infrastructure
* Text indexing

---

template: content
# MongoDB: When?
* Internet of things (sensor data)
* Mobile applications (geospatial indexes)
* Real-time analytics
* Catalogs
* Content management
* Inventory management
* Shopping cart
* Messaging applications
* Log file aggregation
* Caching
* Adserving

---

template: content
# MongoDB: Client/Server
.todo[IMAGE]

---

template: content
# MongoDB: Shell

Connect to a specific database with `mongo <DATABASE-NAME>`
```shell
$ mongo examples
```

Connected to the database `examples`
```javascript
MongoDB shell version: 3.0.6
connecting to: examples
>
```

It's a javascript interpreter (V8)
```javascript
> 12 * 16
192

> "Hello MongoDB".split(" ")
[ "Hello", "MongoDB" ]

> (function(who) { return "Hello " + who })("MongoDB")
Hello MongoDB
```

---

template: content
# MongoDB: Shell

The database is represented with the global variable `db`
```javascript
> db.getName()
examples

> db.getName() === "examples"
true

> db
examples

> db.toString() === "examples"
true
```

You can switch database with the `use` command
```javascript
> use test
switched to db test

> db
test
```

---

template: content
# MongoDB: Shell

Collections can be selected with `db.getCollection` method or via dot notation
```javascript
> db.getCollectionNames()
> [ "restaurants", "system.indexes" ]

> db.getCollection("restaurants")
examples.restaurants

> db.restaurants
examples.restaurants

> db.restaurants.constructor
function DBCollection() { [native code] }
```

Collections and databases are created lazily when a document is inserted

---

template: section
# Insert, Query, Update and Delete

---

template: section
# Aggregation Framework

---

template: section
# Data Modeling and Design

---

template: section
# Data Workshop

---

template: section
# Design Workshop
