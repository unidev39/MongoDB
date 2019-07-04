db.likesearch.drop()
db.likesearch.insert({"c1":"aaaa","c2":"aaaa"})
db.likesearch.insert({"c1":"bbbb","c2":"bbbb"})
db.likesearch.insert({"c1":"cccc","c2":"bbbb"})
db.likesearch.insert({"c1":"1","c2":"1"})
db.likesearch.insert({"c1":2,"c2":2})
db.likesearch.insert({"c1":3,"c2":2})
db.likesearch.find()
/*
{ "_id" : ObjectId("5d1e265a0f39db1aecf1a1a3"), "c1" : "aaaa", "c2" : "aaaa" }
{ "_id" : ObjectId("5d1e26600f39db1aecf1a1a4"), "c1" : "bbbb", "c2" : "bbbb" }
{ "_id" : ObjectId("5d1e267a0f39db1aecf1a1a5"), "c1" : "cccc", "c2" : "bbbb" }
{ "_id" : ObjectId("5d1e26940f39db1aecf1a1a6"), "c1" : "1", "c2" : "1" }
{ "_id" : ObjectId("5d1e269a0f39db1aecf1a1a7"), "c1" : 2, "c2" : 2 }
{ "_id" : ObjectId("5d1e26a00f39db1aecf1a1a8"), "c1" : 3, "c2" : 2 }
*/
db.likesearch.aggregate(
    [ 
        { "$project": { 
            "c1": { "$toString": "$c1" },
			"c2": { "$toString": "$c2" }
        }}, 
        {"$match": {$or: [{c1: /.*a.*/},{c2: /.*a.*/}]} }
    ]
)
/*
{ "_id" : ObjectId("5d1e265a0f39db1aecf1a1a3"), "c1" : "aaaa", "c2" : "aaaa" }
*/

db.likesearch.aggregate(
    [ 
        { "$project": { 
            "c1": { "$toString": "$c1" },
			"c2": { "$toString": "$c2" }
        }}, 
        {"$match": {$or: [{c1: /.*2.*/},{c2: /.*2.*/}]} }
    ]
)
/*
{ "_id" : ObjectId("5d1e269a0f39db1aecf1a1a7"), "c1" : "2", "c2" : "2" }
{ "_id" : ObjectId("5d1e26a00f39db1aecf1a1a8"), "c1" : "3", "c2" : "2" }
*/
db.likesearch.aggregate(
    [ 
        { "$project": { 
            "c1": { "$toString": "$c1" },
			"c2": { "$toString": "$c2" }
        }}, 
        {"$match": {$or: [{c1: /.*2.*/},{c2: /.*2.*/}]} },
		{ $sort : { c1 : -1} }
    ]
)
/*
{ "_id" : ObjectId("5d1e26a00f39db1aecf1a1a8"), "c1" : "3", "c2" : "2" }
{ "_id" : ObjectId("5d1e269a0f39db1aecf1a1a7"), "c1" : "2", "c2" : "2" }
*/

