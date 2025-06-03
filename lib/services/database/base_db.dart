import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as new_db;

class BaseDBModel
{
  //TODO use new db method, replace all old DB method with new

  late File _dbpath;
  String dbName = "Base";

  Future<new_db.Database> loadDB() async {
    //path to Media DB

    if (Platform.isWindows || Platform.isLinux) {
      // Initialize FFI
      new_db.sqfliteFfiInit();
    }

    var databaseFactory = new_db.databaseFactoryFfi;
    _dbpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\$dbName.db");

    late new_db.Database db;

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
