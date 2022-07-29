import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newcustomerform/DBHelper.dart';
import 'package:newcustomerform/viewpage.dart';
import 'package:sqflite/sqflite.dart';

class Insertpage extends StatefulWidget {
  Map? map;
  String? method;

  Insertpage(this.method, {this.map});

  @override
  State<Insertpage> createState() => _InsertpageState();
}

class _InsertpageState extends State<Insertpage> {

  bool hindi = false;
  bool gujarati = false;
  bool english = false;
  bool marathi = false;


  DateTime selectedDate = DateTime.now();

  var select;

  List listitem = [
    "Surat",
    "Vadodara",
    "Ahmedabad",
    "Junagadh",
    "Navsari",
    "Bhuj"
  ];

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
   bool _passwordVisible = false;
  String? tgender;

  TextEditingController tname = TextEditingController();
  TextEditingController temail = TextEditingController();
  TextEditingController tphone = TextEditingController();
  TextEditingController tpassword = TextEditingController();
  TextEditingController tconfirmpassword = TextEditingController();
  TextEditingController tdob = TextEditingController();
  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    if(widget.method=="update")
      {
        tname.text=widget.map!['name'];
        temail.text=widget.map!['email'];
        tphone.text=widget.map!['phone'];
        tpassword.text=widget.map!['password'];
        tconfirmpassword.text=widget.map!['confirmpassword'];
        tgender=widget.map!['gender'];
        select=widget.map!['city'];
        tdob.text=widget.map!['dob'];

      }
    DBHelper().createDatabase().then((value) {
      db = value;
    },);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Form(
        key:  _formkey,
        child: ListView(
          children: [
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Text(
                    "Login Page",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tname,
                    textInputAction: TextInputAction.next,
                    textCapitalization: TextCapitalization.words,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Full Name"),
                    validator: ( value){
                      if(value!.isEmpty){
                        return "Please Enter Name";
                      }
                      if(!RegExp( r'^[a-z A-Z,.\-]+$').hasMatch(value)){
                        return 'Please enter valid full name';
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: temail,
                    onChanged: (value) {
                    },
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), labelText: "Email"),
                    validator:(value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter Email";
                      }
                      if(!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)){
                        return "Please Enter Valid Email";
                      }
                      return null;
                    },

                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    controller: tphone,
                    textInputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Phone Number"),
                    validator:(value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter Phone Number";
                      }
                      if(value.length<9){
                        return "Please Enter Valid Phone Number";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Gender",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
                Column(
                  children: <Widget>[

                    ListTile(
                      title: Text("Male"),
                      leading: Radio(
                          value: "male",
                          groupValue: tgender,
                          onChanged: (value){
                            setState(() {
                              tgender = value.toString();
                            });
                          }),
                    ),

                    ListTile(
                      title: Text("Female"),
                      leading: Radio(
                          value: "female",
                          groupValue: tgender,
                          onChanged: (value){
                            setState(() {
                              tgender = value.toString();
                            });
                          }),
                    ),

                    ListTile(
                      title: Text("Other"),
                      leading: Radio(
                          value: "other",
                          groupValue: tgender,
                          onChanged: (value){
                            setState(() {
                              tgender = value.toString();
                            });
                          }),
                    )

                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text(
                        "Language",
                        style: TextStyle(
                            fontSize: 17, fontWeight: FontWeight.bold),
                      ),
                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              hindi = value!;
                            });
                          },
                          value: hindi),
                      Text("Hindi"),
                      SizedBox(
                        width: 20,
                      ),

                      Checkbox(
                          onChanged: (value) {
                            setState(() {
                              gujarati = value!;
                            });
                          },
                          value: gujarati),
                      Text("Gujarati"),
                    ],
                  ),
                ),
                Row(
                  children: [
                    SizedBox(
                      width: 84,
                    ),
                    Checkbox(
                        onChanged: (value) {
                          setState(() {
                            english = value!;
                          });
                        },
                        value: english),
                    Text("English"),
                    SizedBox(
                      width: 8,
                    ),
                    Checkbox(
                        onChanged: (value) {
                          setState(() {
                            marathi = value!;
                          });
                        },
                        value: marathi),
                    Text("Marathi"),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Text("City",
                          style: TextStyle(
                              fontSize: 17, fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: 60,
                      ),
                      DropdownButton(
                        hint: Text("Select City: "),
                        underline: Container(
                          height: 2,
                          color: Colors.blue,
                        ),
                        value: select,
                        onChanged: (value) {
                          setState(() {
                            select = value as String;
                          });
                        },
                        items: listitem.map((valueitem) {
                          return DropdownMenuItem(
                            value: valueitem,
                            child: Text(valueitem),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    controller: tdob,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Date of Birth",
                      suffixIcon: IconButton(
                          onPressed: () {
                            _selectDate(context);
                            setState(() {

                            });
                          },
                          icon: Icon(
                            Icons.calendar_today,
                            color: Colors.blue,
                          )),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "PassWord",
                      suffixIcon: IconButton(
                        icon: Icon(
                          // Based on passwordVisible state choose the icon
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),),
                    controller: tpassword,
                    validator: (PassCurrentValue){
                      RegExp regex=RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');
                      var passNonNullValue=PassCurrentValue??"";
                      if(passNonNullValue.isEmpty){
                        return ("Password is required");
                      }
                      else if(passNonNullValue.length<6){
                        return ("Password Must be more than 5 characters");
                      }
                      else if(!regex.hasMatch(passNonNullValue)){
                        return ("Password should contain upper,lower,digit and Special character ");
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    textInputAction: TextInputAction.next,
                    obscureText: !_passwordVisible,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: "Confirm Password"),
                    controller: tconfirmpassword,
                    validator:(value){
                      if(value!.isEmpty)
                      {
                        return "Please Enter re-password";
                      }
                      if(tpassword.text!=tconfirmpassword.text){
                        return "Password Do Not Match";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(height: 20,),
                ElevatedButton(onPressed: () async {
                  String name = tname.text;
                  String email = temail.text;
                  String phone = tphone.text;
                  String password = tpassword.text;
                  String confirmpassword = tconfirmpassword.text;
                  String dob = tdob.text;

                    // if(_formkey.currentState!.validate()){

                     if(widget.method=="submit"){
                       String qry = "INSERT INTO Test(name,email,phone,password,confirmpassword,gender,dob,city) VALUES ('$name','$email','$phone','$password','$confirmpassword','$tgender','$dob','$select')";
                       int id = await db!.rawInsert(qry);
                       print(id);

                       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                         return Viewpage();
                       },));
                       if(id>0){
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                              return Viewpage();
                          },));
                       }else{
                         print("Not Updated! Try Again");
                       }
                     }else{
                       String q="update Test set name='$name',email='$email',phone='$phone',password='$password',confirmpassword='$confirmpassword',gender='$tgender',dob='$dob',city='$select' where id=${widget.map!['id']}";
                       int id = await db!.rawUpdate(q);
                       print("id=$id");
                       if(id==1)
                       {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                           return Viewpage();
                         },));
                       }
                     }
                    // }
                }, child: Text("${widget.method}"))
              ],
            ),
          ],
        ),
      ),
    );
  }
  _selectDate(BuildContext context) async {
    final selected = await showDatePicker(

      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2023),
    );
    if (selected != null && selected != selectedDate)
      setState(() {
        selectedDate = selected;
      });
    tdob.text = "${selectedDate.day}/${selectedDate.month}/${selectedDate.year}";
  }
}
