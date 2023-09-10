import 'package:amplify/models/database/base_db_model.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:amplify/models/Source_model.dart';

class MediaDBModel extends baseDBModel
{
  MediaDBModel();

  @override
  // TODO: implement dbName
  String get dbName => "Media cache";

  Future<void> deleteMediaTable(MediaSource source)
  async {
    Database db = await  loadDB();;
    db.execute('''
    DROP TABLE '${source.sourceID}';''');

    db.dispose();
  }

  //Private functions
  Future<void> createMediaTable(String sourceID)
  async {
    Database db = await  loadDB();
    //TODO block users from entering ' single comma
    db.execute('''
    CREATE TABLE  IF NOT EXISTS '$sourceID' (
        id INTEGER NOT NULL PRIMARY KEY,  
        mediaPath TEXT,
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
    db.dispose();
  }


}