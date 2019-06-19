> db.unique_chat_id.drop()
/*
true
*/
> db.unique_chat_id.findAndModify({
...     query: { year: "2019", month: "01"},
...     sort: { month: 1 },
...     update: { $set: { increment: "000001" } },
...     upsert: true,
...     new: true
... })
/*
{
        "_id" : ObjectId("5d0a008574fcda95534789cf"),
        "month" : "01",
        "year" : "2019",
        "increment" : "000001"
}
*/
> db.unique_chat_id.find()
/*
{ "_id" : ObjectId("5d0a008574fcda95534789cf"), "month" : "01", "year" : "2019", "increment" : "000001" }
*/

> db.unique_chat_id.findAndModify({
...     query: { year: "2019", month: "01"},
...     sort: { month: 1 },
...     update: { $set: { increment: "000002" } },
...     upsert: true,
...     new: true
... })
/*
{
        "_id" : ObjectId("5d0a008574fcda95534789cf"),
        "month" : "01",
        "year" : "2019",
        "increment" : "000002"
}
*/
> db.unique_chat_id.find()
/*
{ "_id" : ObjectId("5d0a008574fcda95534789cf"), "month" : "01", "year" : "2019", "increment" : "000002" }
*/
