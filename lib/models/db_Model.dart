import 'dart:io';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/views/widgets/item%20grid/source_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class DBModel
{
  DBModel({required this.mediaDB});

  Database mediaDB;

  late File _mediaDBpath;

  //Private functions
  void _createMediaTable(String sourceID)
  {

    //TODO block users from entering ' single comma
    mediaDB.execute('''
    CREATE TABLE  IF NOT EXISTS 'media_$sourceID' (
        id INTEGER NOT NULL PRIMARY KEY,  
        title TEXT,
        durationMs REAL,
        artist TEXT,
        album TEXT,
        albumArtist TEXT,
        trackNumber INTEGER,
        trackTotal INTEGER,
        discNumber INTEGER,
        discTotal INTEGER,
        year INTEGER,
        genre TEXT,
        picture BLOB,
        fileSize INTEGER
    ); ''');
  }

  //Sources

  void _createSourceTable(MediaSource source)
  {

    mediaDB.execute('''
    CREATE TABLE  IF NOT EXISTS 'sources' (
        id INTEGER NOT NULL PRIMARY KEY,  
        sourceName TEXT,
        mediaTableName TEXT,
        mediaGroup TEXT,
        primaryLabel TEXT,
        secondaryLabel TEXT,
        sourceDirectorys BLOB
    ); ''');
  }

  void addSourceToDB(MediaSource source)
  {
    _createMediaTable(source.sourceID);
      _createSourceTable(source);

      final stmt = mediaDB.prepare('''INSERT INTO sources (
      sourceName,
       mediaTableName,
       mediaGroup,
       primaryLabel,
       secondaryLabel,
       sourceDirectorys
       ) VALUES (?,?,?,?,?,?)''');

      stmt.execute([
        source.sourceName,
        source.sourceID,
        source.mediaGroup.toString(),
        source.primaryLabel.toString(),
        source.secondaryLabel.toString(),
        source.sourceDirectorys.toString(),
      ]);
  }


  //Getters

  Database getMediaDB()
  {
    return mediaDB  = sqlite3.open(_mediaDBpath.path);
  }

  void saveDB()
  {

  }

  Future<Database> loadDB() async {
    //path to Media DB
     _mediaDBpath  = File("${await getApplicationCacheDirectory().then((value) => value.path)}\\Media.db");

    print(_mediaDBpath.path);

    //Check if it exists and make a new file, or open existing
    if( await _mediaDBpath.exists() == false)
      {
        //Create the file and write nothing
        _mediaDBpath.writeAsString("");
      }

     mediaDB = sqlite3.open(_mediaDBpath.path);
    return mediaDB;
    //_mediaDB.dispose();
  }

  void deleteData()
  {
    //_mediaDB.execute('DROP TABLE media');
  }

}