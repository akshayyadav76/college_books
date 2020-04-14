import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart' as path;
import 'dart:async';


class DatabaseModel{

  //(1)  first i have to get database or either create database

  static Future<Database>myDatabase() async{

    var dbpath =await getDatabasesPath(); // folder of data destionary where databaese store or creat

    return openDatabase(path.join(dbpath,'books.db'),
        onCreate: (db,version){
      db.execute(
           "CREATE TABLE saved(bookCodeNameId TEXT PRIMARY KEY,bookName TEXT,bookCover TEXT,url TEXT,bookPath TEXT,semester INTEGER )");
        },version: 1);
  }

  static Future<void>insert(String table,Map<String,dynamic>data)async{
    final db= await DatabaseModel.myDatabase();
    print("data base instiialrdf ${db}");
    db.insert(table, data);
  }

  static Future<List<Map<String,dynamic>>>read(String table)async{
    final db=await DatabaseModel.myDatabase();
    return db.query(table);
  }

  static Future<void>delete(String table,String bookCodeNameId)async{
    final db= await DatabaseModel.myDatabase();
    db.delete(table,where: bookCodeNameId//,whereArgs: [bookId]
    );
  }

}