--7.0.3
db.createCollection('tbl_cib')

db.tbl_cib.insertOne({name: "Devesh", age: 44})

db.tbl_cib.insertMany([{name: "Devesh", age: 44}, {name: "Madhu", age: 44}])

db.tbl_cib.bulkWrite([
{ insertOne : { document : { name: "Devesh", age: 25 } } },
{ updateOne : { filter : { name: "Madhu" }, update : { $set : { age: 40 } } } },
{ deleteOne : { filter : { name: "Manish" } } }
])

-- To Create Collection In Specfic Database
> show collections

> use Mongodb_1
/*
switched to db Mongodb_1
*/

> db.createCollection("table_1")
/*
{ "ok" : 1 }
*/
> show collections
/*
table_1
*/

> db.createCollection("table_2",{capped : true, size : 6142800, max : 10000})
/*
{ "ok" : 1 }
*/

> show collections
/*
table_1
table_2
*/
> db.getCollectionNames()
/*
[ "table_1", "table_2" ]
*/

-- To Drop the Collection
> db.table_2.drop()
/*
true
*/
> db.getCollectionNames()
/*
[ "table_1" ]
*/
> show collections
/*
table_1
*/

-- To insert document into collection
> db.table_1.insert({"C_1":"a","C_2":"b"})
/*
WriteResult({ "nInserted" : 1 })
*/

> db.table_1.insert({col_1 : 'test'})
/*
WriteResult({ "nInserted" : 1 })
*/

> db.table_1.insert([{col_1 : 'test5'},{C_1 : 'a', C_2 : 'b', col_1 : 'abc'}])
/*
BulkWriteResult({
        "writeErrors" : [ ],
        "writeConcernErrors" : [ ],
        "nInserted" : 2,
        "nUpserted" : 0,
        "nMatched" : 0,
        "nModified" : 0,
        "nRemoved" : 0,
        "upserted" : [ ]
})
*/

> db.table_1.save([{col_1 : 'test5'},{C_1 : 'a', C_2 : 'b', col_1 : 'abc'}])
/*
BulkWriteResult({
        "writeErrors" : [ ],
        "writeConcernErrors" : [ ],
        "nInserted" : 2,
        "nUpserted" : 0,
        "nMatched" : 0,
        "nModified" : 0,
        "nRemoved" : 0,
        "upserted" : [ ]
})
*/

>db.post_data.insert([
   {
      c1: 'MongoDB', 
      c2: 'MongoDB is no sql database',
      c3: 'unidev point',
      c4: 'unidev39@gamil.com',
      c5: ['mongodb', 'database', 'NoSQL'],
      c6: 100
   },	
   {
      c1: 'NoSQL Database', 
      c2: "NoSQL database doesn't have tables",
      c3: 'unidev point',
      c4: 'unidev39@gamil.com',
      c5: ['mongodb', 'database', 'NoSQL'],
      c6: 20, 
      comments: [	
         {
            user:'unidev',
            message: 'My first comment',
            dateCreated: new Date(2019,04,22,2,35),
            like: 0 
         }
      ]
   }
])
/*
BulkWriteResult({
        "writeErrors" : [ ],
        "writeConcernErrors" : [ ],
        "nInserted" : 2,
        "nUpserted" : 0,
        "nMatched" : 0,
        "nModified" : 0,
        "nRemoved" : 0,
        "upserted" : [ ]
})
*/

-- Select Query Document
> db.table_1.find()
/*
{ "_id" : ObjectId("5cbd7a897dd02a3502ab7d90"), "C_1" : "a", "C_2" : "b" }
{ "_id" : ObjectId("5cbe8117418d1db16ec9db0f"), "col_1" : "test" }
{ "_id" : ObjectId("5cbe8248418d1db16ec9db13"), "C_1" : "a", "C_2" : "b", "col_1" : "abc" }
{ "_id" : ObjectId("5cbe82ca418d1db16ec9db15"), "col_1" : "test5" }
{ "_id" : ObjectId("5cbe82ca418d1db16ec9db16"), "C_1" : "a", "C_2" : "b", "col_1" : "abc" }
*/
> db.table_1.find().pretty()
/*
{ "_id" : ObjectId("5cbd7a897dd02a3502ab7d90"), "C_1" : "a", "C_2" : "b" }
{ "_id" : ObjectId("5cbe8117418d1db16ec9db0f"), "col_1" : "test" }
{
        "_id" : ObjectId("5cbe8248418d1db16ec9db13"),
        "C_1" : "a",
        "C_2" : "b",
        "col_1" : "abc"
}
{ "_id" : ObjectId("5cbe82ca418d1db16ec9db15"), "col_1" : "test5" }
{
        "_id" : ObjectId("5cbe82ca418d1db16ec9db16"),
        "C_1" : "a",
        "C_2" : "b",
        "col_1" : "abc"
}
*/

cursor = db.post_data.find();
while ( cursor.hasNext() ) {
   printjson( cursor.next() );
}


---------------------------------------------
-- Update the relevant collection
> db.<relevant_collection_name>.updateOne({name:"<relevant_user_name"},{$set:{pwd:"<relevant_password>"}})
> db.<relevant_collection_name>.updateOne({name:"<relevant_user_name"},{$set:{lockedAccountByMultiTry:false}})
> db.<relevant_collection_name>.updateOne({name:"<relevant_user_name"},{$set:{passwordExpiryDate:"<releavnt_date>"}})
> exit
