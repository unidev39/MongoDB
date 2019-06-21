var p = 1;
if (p == 1) { print(p); } else { print('NO'); }

for (var i = 1; i <= 5; i++) {
   print(i)
}

function fn_year_month() {
  var date  = new ISODate();
  var str   = date.toISOString();
  var year  = str.substring(0, 4);
  var month = str.substring(5, 7);
  return year+""+month;
}

for (i = 0; i <= 6; i=i+1){
 print(myFunction()+""+"00000"+""+i)
}

for (var i = 1; i <= 25; i++) {
   db.collectionName.insert({ x : i })
}


