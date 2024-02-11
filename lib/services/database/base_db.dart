import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as newDB;

class BaseDBModel
{
  //TODO use new db method, replace all old DB method with new

  late File _dbpath;
  String dbName = "Base";

  Future<newDB.Database> loadDB() async {
    //path to Media DB

    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      newDB.sqfliteFfiInit();
    }

    var databaseFactory = newDB.databaseFactoryFfi;
    _dbpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\${dbName}.db");

    late newDB.Database db;

    //Check if it exists and make a new file, or open existing
    if( await _dbpath.exists() == false)
    {
      //Create the file and write nothing
      await _dbpath.writeAsString("");

       db = await databaseFactory.openDatabase(
    _dbpath.path);
    }
    else
      {
        db = await databaseFactory.openDatabase(
        _dbpath.path,);
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