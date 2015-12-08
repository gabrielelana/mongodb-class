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

template: content
# Insert

We are going to insert our first document in a collection
```javascript
> db.coders.insert({
... username: "gabrielelana",
... email: "gabriele.lana@gmail.com"
... })

WriteResult({ "nInserted" : 1 })

> db.coders.count()
1

> db.coders.find()
{
  "_id" : ObjectId("5666d7d9348d8fdba2aa92fd"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```
* A collection `coders` has been created in database `examples`
* A document has been inserted in the collection `coders`
* The field `_id` has been added in the document with a new `ObjectId`
* Try to insert a document with an `_id` field and see what happens

---

template: content
# Query: Find

To query a collection we use `find(<QUERY>, <PROJECTION>)`

```javascript
> db.coders.find()
{
  "_id" : ObjectId("5666d7d9348d8fdba2aa92fd"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```

No query it's like an empty query `{}` and an empty query always matches, so `find()` retrieves all documents in a collection

```javascript
> db.coders.find({})
{
  "_id" : ObjectId("5666d7d9348d8fdba2aa92fd"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```

---

template: content
# Query: Find by Value

The most simple thing is to match documents based on values

```javascript
> db.coders.insert({
... username: "albertobrandolini",
... email: "alberto.brandolini@gmail.com"
... })
WriteResult({ "nInserted" : 1 })

> db.coders.find({username: "gabrielelana"})
{
  "_id" : ObjectId("5666d7d9348d8fdba2aa92fd"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}

> db.coders.find({username: "albertobrandolini"})
{
  "_id" : ObjectId("5666df1710e86a873c801e27"),
  "username" : "albertobrandolini",
  "email" : "alberto.brandolini@gmail.com"
}
```

---

template: content
# Query: Find by Value

We can match values on multiple fields

```javascript
> db.coders.find({username: "gabrielelana", email: "gabriele.lana@gmail.com"})
{
  "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```

Same as combine multiple queries with an `$and` operator

```javascript
> db.coders.find({
... $and: [
...   {username: "gabrielelana"},
...   {email: "gabriele.lana@gmail.com"}
... ]})
{
  "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```

---

template: content
# Query: Combinators

The `$or` operator behaves as expected
```javascript
> db.coders.find({
... $or: [
...   {username: "gabrielelana"},
...   {username: "albertobrandolini"}
... ]})
{
  "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
{
  "_id" : ObjectId("5666df1710e86a873c801e27"),
  "username" : "albertobrandolini",
  "email" : "alberto.brandolini@gmail.com"
}
```

---

template: content
# Query: Cursor

The `find` method returns a cursor, this means that a query it's not executed until the content of the cursor is not printed

```javascript
> r = db.coders.find()
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"), ...}
{ "_id" : ObjectId("5666df1710e86a873c801e27"), ...}

> r.constructor
function DBQuery() { [native code] }

> db.coders.find().count()
2

> db.coders.find().skip(1)
{ "_id" : ObjectId("5666df1710e86a873c801e27"), ...}

> db.coders.find().limit(1)
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"), ...}
```

Try to ask for help with `r.help()`

---

template: content
# Query: Project fields

You can limit the result to fields you are interested in
```javascript
> db.coders.find({}, {username: 1})
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana"
}
{ "_id" : ObjectId("5666df1710e86a873c801e27"),
  "username" : "albertobrandolini"
}

> db.coders.find({}, {username: 1, _id: 0})
{ "username" : "gabrielelana" }
{ "username" : "albertobrandolini" }

> db.coders.find({}, {_id: 0})
{ "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
{ "username" : "albertobrandolini",
  "email" : "alberto.brandolini@gmail.com"
}
```

---

template: content
# Query: Comparison operators

Instead of values we can use comparison operators like, the simplest is `$eq` which is equivalent to the value itself

```javascript
> db.coders.find({username: "gabrielelana"})
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}

> db.coders.find({username: {$eq: "gabrielelana"}})
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
```

The operator `$ne` it's the opposite

```javascript
> db.coders.find({username: {$neq: "gabrielelana"}})
{ "_id" : ObjectId("5666df1710e86a873c801e27"),
  "username" : "albertobrandolini",
  "email" : "alberto.brandolini@gmail.com"
}
```

---

template: content
# Query: Comparison operators

The operator `$in` could be a shortcut for the `$or` logical operator

```javascript
> db.coders.find({username: {$in: ["gabrielelana", "albertobrandolini"]}})
{ "_id" : ObjectId("5666d875348d8fdba2aa92fe"),
  "username" : "gabrielelana",
  "email" : "gabriele.lana@gmail.com"
}
{ "_id" : ObjectId("5666df1710e86a873c801e27"),
  "username" : "albertobrandolini",
  "email" : "alberto.brandolini@gmail.com"
}
```

The difference is that you can use only values inside the `$in` array whereas with `$or` you can compose arbitrary complex query objects

---

template: content
# Query: Comparison operators

To compare numbers use: `$lt`, `$lte`, `$gt`, `$gte`

```javascript
> db.inventory.insert({name: "Bread of Force", quantity: 9})
> db.inventory.insert({name: "Carpet of Flying", quantity: 2})
> db.inventory.insert({name: "Flame Extinguishing", quantity: 16})

> db.inventory.find({quantity: {$gt: 2}}, {_id: 0})
{ "name" : "Bread of Force" , "quantity": 9 }
{ "name" : "Flame Extinguishing", "quantity": 16 }

> db.inventory.find({quantity: {$lt: 9}}, {_id: 0})
{ "name" : "Carpet of Flying", "quantity": 2 }

> db.inventory.find({quantity: {$gt: 5, $lt: 10}}, {_id: 0})
{ "name" : "Bread of Force", "quantity" : 9 }
```

---

template: content
# Query: Find in embedded documents

```javascript
> db.restaurants.find({"address.zipcode": "10462"}, {name: 1, _id: 0})
{ "name" : "Morris Park Bake Shop" }
{ "name" : "The New Starling Athletic Club Of The Bronx" }
{ "name" : "Lulu'S Coffee Shop" }
{ "name" : "Bronx Grill" }
{ "name" : "Sabrosura Restaurant" }
{ "name" : "John & Joe Pizzeria & Restaurant" }
{ "name" : "Castlehill Diner" }
{ "name" : "Venice Pizza" }
{ "name" : "Wendy'S" }
{ "name" : "The Pizza Place" }
{ "name" : "Chick-N-Ribs" }
{ "name" : "Zaro'S Bread Basket" }
{ "name" : "Celeste'S Snack Bar" }
{ "name" : "Park Billiards" }
{ "name" : "Mcdonald'S" }
{ "name" : "Mcdonald'S" }
{ "name" : "Carvel Ice Cream" }
{ "name" : "Archer Sports Bar" }
{ "name" : "Pizza Express" }
{ "name" : "Johnny'S O'S" }
...
```

---

template: content
# Query: Array transparency

```javascript
> db.coders.insert({
... username: "filippoliverani",
... email: [
...   "filippo.liverani@gmail.com",
...   "filippo.liverani@xpeppers.it"]
... })
WriteResult({ "nInserted" : 1 })

> db.coders.find({email: "filippo.liverani@gmail.com"})
{ "_id" : ObjectId("5666f6fd10e86a873c801e2d"),
  "username" : "filippoliverani",
  "email" : [ "filippo.liverani@gmail.com", "filippo.liverani@xpeppers.it" ]
}

> db.coders.find({email: "filippo.liverani@xpeppers.it"})
{ "_id" : ObjectId("5666f6fd10e86a873c801e2d"),
  "username" : "filippoliverani",
  "email" : [ "filippo.liverani@gmail.com", "filippo.liverani@xpeppers.it" ]
}
```

---

template: content
# Query: Arrays of embedded documents

Find all restaurants with at least a grade after 2015

```javascript
> db.restaurants.find({"grades.date": {$gte: new Date(2015, 0, 0)}}).count()
242
> db.restaurants.find({"grades.date": {$gte: new Date(2015, 0, 0)}}).limit(1)
{
  "_id" : ObjectId("56669d14be2e0c48d1024473"),
  "address" : ...
  "borough" : "Staten Island",
  "cuisine" : "Delicatessen",
  "grades" : [
    {
      "grade" : "A",
      "score" : 3,
      "date" : ISODate("2015-01-09T00:00:00Z")
    },
    ...
  ],
  "name" : "Bagels N Buns",
  "restaurant_id" : "40363427"
}
```

---

template: content
# Query: Arrays of embedded documents

Find all restaurants with a **grade "A" after 2015**

```javascript
> db.restaurants
... .find({"grades.date": {$gte: new Date(2015, 0, 0)}, "grades.grade": "A"})
... .count()
240
```

... But in the result set

```javascript
{ ...
  "grades" : [
    { "date" : ISODate("2015-01-05T00:00:00Z"),
      "grade" : "B",
      "score" : 9
    },
    { "date" : ISODate("2014-07-02T00:00:00Z"),
      "grade" : "A",
      "score" : 2
    },
    ...
  ],
}
```

---

template: content
# Query: Arrays of embedded documents

You cannot use object as values in queries

```javascript
> db.restaurants.find(
...   {grades: {
...     date: {$gte: new Date(2015, 0, 0)},
...     grade: "A"
...   }}
... ).count()
0
```

You need to use `$elemMatch` operator

```javascript
> db.restaurants.find(
...   {grades: {
...     $elemMatch: {
...       date: {$gte: new Date(2015, 0, 0)},
...       grade: "A"
...     }
...   }}
... ).count()
190
```

---

template: content
# Query: Regular Expressions

Find all restaurants located in a "Street" (ex "East 66 Street")

```javascript
> db.restaurants.find({"address.street": /Street$/}).count()
1221
```

Find all restaurants located in a "Avenue" (ex "Stillwell Avenue")

```javascript
> db.restaurants.find({"address.street": /Avenue$/}).count()
1481
```

Find all restaurants that are **not located** in a "Street" or a "Avenue"
```javascript
> db.restaurants.find(
...   {$and: [
...     {"address.street": {$not: /Avenue$/}},
...     {"address.street": {$not: /Street$/}}
...   ]}
... ).count()
1069
```

---

template: content
# Query: Spatial Queries

Find all restaurants near (within 500 meters) Broadway (coordinates: -74.0164697, 40.7045116)

```javascript
> db.restaurants.createIndex({"address.coord": "2dsphere"})

> db.restaurants.find({
...   "address.coord": {
...     $near: {type: "Point", coordinates: [-74.0164697,40.7045116]},
...     $maxDistance: 500
...   }
... }).count()
21
```

Find a place in New York City and try it for yourself

---

template: content
# Query: Spatial Queries

Let's get crazy and show the full shell potential

```javascript
var latitude = 40.702147,
    longitude = -74.015794,
    center = [latitude, longitude].join(","),
    baseUrl = "https://maps.googleapis.com/maps/api/staticmap"
    params = "center=" + center + "&zoom=15&size=800x600&maptype=roadmap"

fromResturantToMarker = function(d) {
  return encodeURI(
    "markers=" + [
      "color:blue",
      "label:" + d.name,
      d.address.coord[1] + "," + d.address.coord[0]
    ].join("|"))
}

markers = db.restaurants.find({
  "address.coord": {
    $near: {type: "Point", coordinates: [longitude, latitude]},
    $maxDistance: 500
  }}
).map(fromResturantToMarker)

baseUrl + "?" + params + "&" + markers.join("&")
```

---

template: content
# Query: Sorting

Find the last graded restaurant. A negative values means **decreasing** order, a positive value mean **increasing** order

```javascript
> db.restaurants.find().sort({"grades.date": -1}).limit(1)
{ "_id" : ObjectId("56669d14be2e0c48d10249a1"),
  "address" : ...,
  "borough" : "Bronx",
  "cuisine" : "American ",
  "grades" : [
    {
      "score" : 4,
      "date" : ISODate("2015-01-20T00:00:00Z"),
      "grade" : "Not Yet Graded"
    }
  ],
  "name" : "Ambassador Diner",
  "restaurant_id" : "40403946"
}
```

Let's check to be sure ;-)

```javascript
> db.restaurants.find({"grades.date": {$gt: ISODate("2015-01-20T00:00:00Z")}})
```

---

template: content
# Query: The Last Resort

In the end you can always rely on `$where` operator, but be mind of the performance penalties!

Find all the restaurants that improved over time

```javascript
> db.restaurants.find({$where:
    function() {
      var grades = this.grades.sort(
        function(l, r) {
          return r.date.getTime() - l.date.getTime()
        }
      );
      for (var i=0; i<grades.length-1; i++) {
        if (grades[i].score > grades[i+1].score) {
          return false
        }
      }
      return true
    }
  }).count()

203
```

---

template: content
# Query: Conclusions

* Queries as objects are easier to compose programmatically (like an AST)
* Not as powerful as SQL but powerful enough for most of the usages
* For a beginner it's more straightforward than SQL
* Easy to be extended programmatically (look at mongodb-shell-extensions)
* When you get used to it it's mostly OK ;-)








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
