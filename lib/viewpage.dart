import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newcustomerform/DBHelper.dart';
import 'package:newcustomerform/insertpage.dart';
import 'package:sqflite/sqflite.dart';

class Viewpage extends StatefulWidget {
  const Viewpage({Key? key}) : super(key: key);

  @override
  State<Viewpage> createState() => _ViewpageState();
}

class _ViewpageState extends State<Viewpage> {
  List<Map<String, Object?>> l = [];

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    Database db = await DBHelper().createDatabase();

    String qry = 'SELECT * FROM Test';
    l = await db.rawQuery(qry);

    print(l);

    status = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customer Data"),
      ),
      body: status
          ? (l.length > 0
              ? ListView.builder(
                  itemCount: l.length,
                  itemBuilder: (context, index) {
                    Map m = l[index];
                    return ListTile(
                      leading: Text("${m['id']}"),
                      title: Text("${m['name']}"),
                      subtitle: Text("${m['phone']}"),
                      trailing: IconButton(onPressed: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) {
                          return Insertpage("update",map:m);
                        },));
                      }, icon: Icon(Icons.edit)),
                    );
                  },
                )
              : Center(child: Text("No Data Found")))
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Insertpage("submit");
        },));
      },child: Icon(Icons.add)),
    );
  }
}
