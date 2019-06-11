-- Without Pagination
db.chats.aggregate(
              [
               { 
                $match: {
                           "agent": ObjectId("5cd271b09af15d7eae121b3c")
                          }
               },
               {
                $group: {
                          _id: {agent: "$agent", customerName: "$customerName",customerMobileNumber:"$customerMobileNumber",customerEmail:"$customerEmail"},
                          'maxendTime': {$max: "$endTime"}
                         }
               },
               {
                '$sort': {'maxendTime':-1}
               }
              ]
             )
/*
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "HARI ROKA", "customerMobileNumber" : "9849124293", "customerEmail" : "sysadmin1@grr.la" }, "maxendTime" : ISODate("2019-06-10T11:09:03.007Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "Raju", "customerMobileNumber" : "60123456789", "customerEmail" : "" }, "maxendTime" : ISODate("2019-06-10T10:09:32.048Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "hari", "customerMobileNumber" : "9849124293", "customerEmail" : "hari@8squarei.com" }, "maxendTime" : ISODate("2019-06-10T08:24:58.553Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "HARI ROKA", "customerMobileNumber" : "9849124293", "customerEmail" : "hari@8squarei.com" }, "maxendTime" : ISODate("2019-06-10T04:48:21.586Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "Sajan", "customerMobileNumber" : "9860336160", "customerEmail" : "" }, "maxendTime" : ISODate("2019-06-07T04:48:24.827Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "nmnnn", "customerMobileNumber" : "324324324", "customerEmail" : "nndf@dsf.com" }, "maxendTime" : ISODate("2019-06-07T04:23:05.264Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "hehe", "customerMobileNumber" : "989765432", "customerEmail" : "sada@da.da" }, "maxendTime" : ISODate("2019-06-07T04:17:34.873Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "siudhir", "customerMobileNumber" : "2343243242342", "customerEmail" : "sdfdsf@sxcz.com" }, "maxendTime" : ISODate("2019-06-07T03:59:51.148Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sdfsdf", "customerMobileNumber" : "324324324324", "customerEmail" : "dsf@dsf.com" }, "maxendTime" : ISODate("2019-06-07T03:44:37.924Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "dsfdsf", "customerMobileNumber" : "324324324", "customerEmail" : "sdf@zdf.com" }, "maxendTime" : ISODate("2019-06-07T03:32:02.938Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sudhir", "customerMobileNumber" : "32432432423432", "customerEmail" : "sudhir@sdf.com" }, "maxendTime" : ISODate("2019-06-07T03:32:02.911Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sdfdsf", "customerMobileNumber" : "3243243242", "customerEmail" : "dsfz@dsf.com" }, "maxendTime" : ISODate("2019-06-06T03:30:40.096Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sudhir", "customerMobileNumber" : "9324324234", "customerEmail" : "sdfsd@dsf.com" }, "maxendTime" : ISODate("2019-06-06T03:02:04.901Z") }
{ "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sdsfdsf", "customerMobileNumber" : "234324234324", "customerEmail" : "sdf@sdf.com" }, "maxendTime" : ISODate("2019-06-05T11:23:31.870Z") }
*/

--With Pagination using "metadata"
db.chats.aggregate(
              [
               { 
                $match: {
                           "agent": ObjectId("5cd271b09af15d7eae121b3c")
                          }
               },
               {
                $group: {
                          _id: {agent: "$agent", customerName: "$customerName",customerMobileNumber:"$customerMobileNumber",customerEmail:"$customerEmail"},
                          'maxendTime': {$max: "$endTime"}
                         }
               },
               {
                '$sort': {'maxendTime':-1}
               },
               { '$facet'    : {
                                   metadata: [ { $count: "total" }, { $addFields: { page: NumberInt(3) } } ],
                                   data: [ { $skip: 6 }, { $limit: 3 } ]
                               }
               }
              ]
             )
/*
{ "metadata" : [ { "total" : 14, "page" : 3 } ],
                 "data" : [ 
                           { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "hehe", "customerMobileNumber" : "989765432", "customerEmail" : "sada@da.da" }, "maxendTime" : ISODate("2019-06-07T04:17:34.873Z") },
                           { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "siudhir", "customerMobileNumber" : "2343243242342", "customerEmail" : "sdfdsf@sxcz.com" }, "maxendTime" : ISODate("2019-06-07T03:59:51.148Z") },
                           { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sdfsdf", "customerMobileNumber" : "324324324324", "customerEmail" : "dsf@dsf.com" }, "maxendTime" : ISODate("2019-06-07T03:44:37.924Z") }
                          ] }
*/

--With Pagination escape "metadata"
db.chats.aggregate(
              [
               { 
                $match: {
                           "agent": ObjectId("5cd271b09af15d7eae121b3c")
                          }
               },
               {
                $group: {
                          _id: {agent: "$agent", customerName: "$customerName",customerMobileNumber:"$customerMobileNumber",customerEmail:"$customerEmail"},
                          'maxendTime': {$max: "$endTime"}
                         }
               },
               {
                '$sort': {'maxendTime':-1}
               },
               { '$facet'    : {
                                 data: [ { $skip: 6 }, { $limit: 3 } ]
                               }
               }
              ]
             )
/*
{ "data" : [ 
            { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "hehe", "customerMobileNumber" : "989765432", "customerEmail" : "sada@da.da" }, "maxendTime" : ISODate("2019-06-07T04:17:34.873Z") },
            { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "siudhir", "customerMobileNumber" : "2343243242342", "customerEmail" : "sdfdsf@sxcz.com" }, "maxendTime" : ISODate("2019-06-07T03:59:51.148Z") },
            { "_id" : { "agent" : ObjectId("5cd271b09af15d7eae121b3c"), "customerName" : "sdfsdf", "customerMobileNumber" : "324324324324", "customerEmail" : "dsf@dsf.com" }, "maxendTime" : ISODate("2019-06-07T03:44:37.924Z") }
           ] }
*/

---------------
db.chats.aggregate([
    {
      $match: {
        agent: ObjectId("5cd271b09af15d7eae121b3c")
      }
    },
    {
      $group: {
        _id: {
          customer: '$customer'
        },
        endTime: { $max: '$endTime' },
        maxChatId: { $max: '$_id' },
        customerName: { $max: '$customerName' },
        customerEmail: { $max: '$customerEmail' },
        customerMobileNumber: { $max: '$customerMobileNumber' }
      }
    },
    {
      $sort: { endTime: -1 }
    },
    { '$facet'    : {
                      data: [ { $skip: 6 }, { $limit: 3 } ]
                    }
    }
  ])
/*
{ "data" : [ 
            { "_id" : { "customer" : ObjectId("5ce4d3d3a2ab4316c88192e6") }, "endTime" : ISODate("2019-06-07T03:44:37.924Z"), "maxChatId" : ObjectId("5cf9dac6abd8103d3d54e763"), "customerName" : "sdfsdf", "customerEmail" : "dsf@dsf.com", "customerMobileNumber" : "324324324324" },
            { "_id" : { "customer" : ObjectId("5cf9d9c7abd8103d3d54e755") }, "endTime" : ISODate("2019-06-07T03:32:02.911Z"), "maxChatId" : ObjectId("5cf9d9c7abd8103d3d54e756"), "customerName" : "sudhir", "customerEmail" : "sudhir@sdf.com", "customerMobileNumber" : "32432432423432" },
            { "_id" : { "customer" : ObjectId("5cf8855c7bc8ee06a9e6c397") }, "endTime" : ISODate("2019-06-06T03:30:40.096Z"), "maxChatId" : ObjectId("5cf8855c7bc8ee06a9e6c398"), "customerName" : "sdfdsf", "customerEmail" : "dsfz@dsf.com", "customerMobileNumber" : "3243243242" }
           ] }
*/