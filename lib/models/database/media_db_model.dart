import 'package:amplify/models/database/base_db_model.dart';

class MediaDBModel extends baseDBModel
{
  MediaDBModel({required super.db});

  @override
  // TODO: implement dbName
  String get dbName => "Media cache";

  //Private functions
  void createMediaTable(String sourceID)
  {

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
  }


}