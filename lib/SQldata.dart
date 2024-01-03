import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class sqldatas{

  sqldatas._init();
  static sqldatas instance = sqldatas._init();
  Database? _database;

  Future<Database> get database async =>  instance._database ?? await creatdatabase();

  creatdatabase() async {
    final paths = getDatabasesPath();
    final path ='$paths/Ritulsdata.db';

    final database = await openDatabase(path,
        version: 1,
        onCreate: (db, version) {
          db.execute("""
   CREATE TABLE MANGUKIYA3012 (
   id INTEGER PRIMARY KEY AUTOINCREMENT,
   name TEXT,
   email TEXT,
   contect TEXT,
   password TEXT,
   image TEXT
   )
   """);
        });
    return database;
  }

  Future<List<Map>> getdata() async {
    final db = await instance.database;
    final sql = "select * from MANGUKIYA3012";
    List<Map> datas = await db.rawQuery(sql);
    return datas;
  }

  updatedata(
      {required String name, required String email, required String password,  required String phone,required String image,  required int id}) async {
    final db = await instance.database;
    String qry =
        "UPDATE MANGUKIYA3012 SET name = '$name', email = '$email', contect = '$phone', password = '$password', image = '$image' WHERE id = $id ";
    await db.rawUpdate(qry).then((value) {
      debugPrint("$value");
    });
  }

  deletdata({required int id}) async {
    final db = await instance.database;
    String qry = "DELETE FROM MANGUKIYA3012 WHERE id = $id ";
    await db.rawDelete(qry).then((value) {
      debugPrint("$value");
    });
  }

  savedata(
      {required String name,
        required String email,
        required String contect,
        required String pw,
        required String image}) async {
    final db =await instance.database;
    db.insert("MANGUKIYA3012", {
      "name":"${name}",
      "email":"${email}",
      "contect":"${contect}",
      "password":"${pw}",
      "image":"${image}"
    });
  }

}