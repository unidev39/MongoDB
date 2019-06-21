--Step 1
-- Create a function to get system year and month for Chats Unique ID
function fn_year_month() {
  var date  = new ISODate();
  var str   = date.toISOString();
  var year  = str.substring(0, 4);
  var month = str.substring(5, 7);
  return year+""+month;
}

-- Step 2
-- Create a function to pad zeroes for Chats Unique ID
function fn_pad_with_zeroes(number, length) {
    var my_string = '' + number;
    while (my_string.length < length) {
        my_string = '0' + my_string;
    }
    return my_string;
}

-- Step 3
-- Create a Collection to store leteset one sequence value for Chats Unique ID
db.counters.drop()
db.counters.insert({_id:"chatid",sequence_value:0})
/*
WriteResult({ "nInserted" : 1 })
*/
db.counters.find()
/*
{ "_id" : "chatid", "sequence_value" : 0 }
*/

-- Step 4
-- Create a function to get next  sequence value for Chats Unique ID
function fn_getnextsequencevalue(sequencename){
   var l_sequenceval = db.counters.findAndModify({
      query: {_id: sequencename },
      update: {$inc:{sequence_value:1}},
      new:true
   });
   return fn_year_month()+""+fn_pad_with_zeroes(l_sequenceval.sequence_value,6);
}

-- Step 5
-- Create a Collection to store chats with Chats Unique ID
db.uniquechatid.drop()
db.uniquechatid.insert({
   "_id":fn_getnextsequencevalue("chatid"),
   "chat_by":"Devesh",
   "message":"Hello"
})
/*
WriteResult({ "nInserted" : 1 })
*/
db.uniquechatid.insert({
   "_id":fn_getnextsequencevalue("chatid"),
   "chat_by":"Suman",
   "message":"Hi"
})
/*
WriteResult({ "nInserted" : 1 })
*/
-- Step 6
-- Verification 
db.uniquechatid.find()
/*
{ "_id" : "201906000001", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201906000002", "chat_by" : "Suman", "message" : "Hi" }
*/
db.counters.find()
/*
{ "_id" : "chatid", "sequence_value" : 2 }
*/

-- Step 7
-- Verification (Change the System Date)
db.uniquechatid.insert({
...    "_id":fn_getnextsequencevalue("chatid"),
...    "chat_by":"Devesh",
...    "message":"Hello"
... })
/*
WriteResult({ "nInserted" : 1 })
*/
> db.uniquechatid.insert({
...    "_id":fn_getnextsequencevalue("chatid"),
...    "chat_by":"Suman",
...    "message":"Hi"
... })
/*
WriteResult({ "nInserted" : 1 })
*/

db.uniquechatid.find()
/*
{ "_id" : "201906000001", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201906000002", "chat_by" : "Suman", "message" : "Hi" }
{ "_id" : "201907000003", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201907000004", "chat_by" : "Suman", "message" : "Hi" }
*/
db.counters.find()
/*
{ "_id" : "chatid", "sequence_value" : 4 }
*/

--Requered Update on Counter Collection to reset the sequence value
db.counters.updateOne(
   { "_id" : "chatid" },
   { $set: { "sequence_value" : 0 } }
);
/*
{ "acknowledged" : true, "matchedCount" : 1, "modifiedCount" : 1 }
*/

db.counters.find()
/*
{ "_id" : "chatid", "sequence_value" : 0 }
*/

db.uniquechatid.insert({
...    "_id":fn_getnextsequencevalue("chatid"),
...    "chat_by":"Devesh",
...    "message":"Hello"
... })
/*
WriteResult({ "nInserted" : 1 })
*/
> db.uniquechatid.insert({
...    "_id":fn_getnextsequencevalue("chatid"),
...    "chat_by":"Suman",
...    "message":"Hi"
... })
/*
WriteResult({ "nInserted" : 1 })
*/

db.uniquechatid.find()
/*
{ "_id" : "201906000001", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201906000002", "chat_by" : "Suman", "message" : "Hi" }
{ "_id" : "201906000003", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201906000004", "chat_by" : "Suman", "message" : "Hi" }
{ "_id" : "201907000001", "chat_by" : "Devesh", "message" : "Hello" }
{ "_id" : "201907000002", "chat_by" : "Suman", "message" : "Hi" }
*/

db.counters.find()
/*
{ "_id" : "chatid", "sequence_value" : 2 }
*/



