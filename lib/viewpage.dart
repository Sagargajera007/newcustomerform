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
  List<Map<String, Object?>> l = List.empty(growable: true);
  Database? db;

  bool status = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllData();
  }

  getAllData() async {
    db = await DBHelper().createDatabase();

    String qry = 'SELECT * FROM Test';
    List<Map<String,Object?>> x = await db!.rawQuery(qry);

    l.addAll(x);
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
                      onLongPress: () {
                        showDialog(

                          builder: (context) {
                            return AlertDialog(
                              title: Text("Delete"),
                              content: Text(
                                  "are you sure want to delete this contact"),
                              actions: [
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                      int id = m['id'];
                                      String q =
                                          "DELETE FROM Test WHERE  id= '$id'";
                                      db!.rawDelete(q).then(
                                        (value) {
                                          l.removeAt(index);
                                          setState(() {});
                                        },
                                      );
                                    },
                                    child: Text("Yes")),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text("No"))
                              ],
                            );
                          }, context: context,
                        );
                      },
                      leading: Text("${m['id']}"),
                      title: Text("${m['name']}"),
                      subtitle: Text("${m['phone']}"),
                      trailing: IconButton(
                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) {
                                return Insertpage("update", map: m);
                              },
                            ));
                          },
                          icon: Icon(Icons.edit)),
                    );
                  },
                )
              : Center(child: Text("No Data Found")))
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(
              builder: (context) {
                return Insertpage("submit");
              },
            ));
          },
          child: Icon(Icons.add)),
    );
  }
}
