import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class BaseDBModel
{
  BaseDBModel()
  {
    loadDB();
  }

  late File _dbpath;
  String dbName = "Base";

  Future<Database> loadDB() async {
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