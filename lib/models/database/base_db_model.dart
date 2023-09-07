import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class baseDBModel
{
  baseDBModel({required this.db});

  Database db;

  late File _dbpath;

  String dbName = "Base";

  //Getters

  Database getDB()
  {
    return db  = sqlite3.open(_dbpath.path);
  }

  void saveDB()
  {

  }

  Future<Database> loadDB() async {
    //path to Media DB
    _dbpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\${dbName}.db");

    //Check if it exists and make a new file, or open existing
    if( await _dbpath.exists() == false)
    {
      //Create the file and write nothing
      _dbpath.writeAsString("");
    }

    db = sqlite3.open(_dbpath.path);
    return db;
    //_mediaDB.dispose();
  }

  void deleteData()
  {
    //_mediaDB.execute('DROP TABLE media');
  }

}