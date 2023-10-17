import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as newDB;
import 'package:sqlite3/sqlite3.dart';

class BaseDBModel
{
  //TODO use new db method, replace all old DB method with new

  late File _dbpath;
  String dbName = "Base";

  Future<Database> loadDB_OLD() async {
    //path to Media DB
    _dbpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\${dbName}.db");

    //Check if it exists and make a new file, or open existing
    if( await _dbpath.exists() == false)
    {
      //Create the file and write nothing
      _dbpath.writeAsString("");
    }

    Database db = sqlite3.open(_dbpath.path);
    return db;
  }

  Future<newDB.Database> loadDB() async {
    //path to Media DB

    newDB.sqfliteFfiInit();
    var databaseFactory = newDB.databaseFactoryFfi;
    _dbpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\${dbName}.db");

    var db = await databaseFactory.openDatabase(
      _dbpath.path,
    );

    //Check if it exists and make a new file, or open existing
    if( await _dbpath.exists() == false)
    {
      //Create the file and write nothing
      _dbpath.writeAsString("");
    }

    return db;
  }

  //Deletes the DB
  Future<bool> deleteDB()
  async {
    if(await _dbpath.exists())
      {
         await _dbpath.delete();
         return true;
      }
    return false;
  }
}