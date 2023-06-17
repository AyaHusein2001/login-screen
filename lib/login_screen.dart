import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:sqflite/sqflite.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  var Emailcont = TextEditingController();
  Database? database;

  var passcont = TextEditingController();
  @override
  void initState() {
    super.initState();
    opendatabase();
    insertindatabase();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40.0,
                ),
                Text(
                  'Login',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 30.0),
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: Emailcont,
                  decoration: InputDecoration(
                    hintText: 'Email Address',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.email),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  controller: passcont,
                  decoration: InputDecoration(
                    hintText: 'Password',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: Icon(Icons.remove_red_eye),
                  ),
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: true,
                  onFieldSubmitted: (value) {
                    print(value);
                  },
                ),
                SizedBox(
                  height: 20.0,
                ),
                Container(
                  width: double.infinity,
                  child: Container(
                    width: 20.0,
                    child: ElevatedButton(
                        onPressed: () {
                          print(Emailcont.text);
                          print(passcont.text);
                        },
                        child: Text(
                          'Login',
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Don\'t have an account ?'),
                    TextButton(onPressed: () {}, child: Text('Register now'))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void opendatabase() async {
    database =
        await openDatabase('todo.db', version: 1, onCreate: (db, version) {
      print('data created');
      db
          .execute(
              'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('${error.toString()}');
      });
    }, onOpen: (db) {
      print('data opened');
    });
  }

  void insertindatabase() async {
   database.transaction((txn)  {
      txn
          .rawInsert(
              'INSERT INTO tasks (title, date, time, status) VALUES("first task", "02222", "182","0")')
          .then((value) {
        print('$value is inserted');
      }).catchError((onError) {
        print('${onError.toString()}');
      });
    });
  }
}
