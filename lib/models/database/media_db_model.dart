import 'dart:io';

import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:amplify/models/Source_model.dart';

class MediaDBModel extends BaseDBModel
{
  MediaDBModel();

  @override
  // TODO: implement dbName
  String get dbName => "Media cache";

  Future<void> deleteMediaTable(MediaSource source)
  async {
    Database db = await  loadDB();
    db.execute('''
    DROP TABLE '${source.sourceID}';''');

    db.dispose();
  }

  Future<void> addMediaToTable(String sourceID, Metadata metadata, Directory filepath)
  async {
    Database db = await  loadDB();
    final stmt = db.prepare('''INSERT INTO  '${sourceID}' 
    (title,
        durationMs,
        artist,
         album,
        albumArtist,
        trackNumber,
        trackTotal,
        discNumber,
        discTotal,
        year,
        genre,
        picture,
        fileSize,
        filePath
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)''');
    stmt
        .execute([
      metadata.title,
      metadata.durationMs,
      metadata.artist,
      metadata.album,
      metadata.albumArtist,
      metadata.trackNumber,
      metadata.trackTotal,
      metadata.discNumber,
      metadata.discTotal,
      metadata.year,
      metadata.genre,
      metadata.picture?.data,
      metadata.fileSize,
      filepath.path,
    ]);
      print("Saved: ${metadata.title}");
    db.dispose();
  }

  //Private functions
  Future<void> createMediaTable(String sourceID)
  async {
    Database db = await  loadDB();
    //TODO block users from entering ' single comma
    db.execute('''
    CREATE TABLE  IF NOT EXISTS '${sourceID}' (
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
        fileSize INTEGER,
        filepath TEXT
    ); ''');
    db.dispose();
  }

// TODO finish this function to return grups names
  Future<List<MediaGroup>> getGroups(MediaSource source, String sourceID )
  async {

    Database db = await  loadDB();
    createMediaTable(sourceID);
    List<MediaGroup> mediaGroups = [];
    late  ResultSet set;

    print("Test");
    print("select DISTINCT album from '${sourceID}'");

    String name = "";

    switch (source.mediaGroup)
    {

      case MediaGroups.album:
        set = db.select("select DISTINCT album from '${sourceID}'");

      case MediaGroups.artest:
        set = db.select("select DISTINCT album from '${sourceID}'");

      case MediaGroups.year:
        set = db.select("select DISTINCT year from '${sourceID}'");

      case MediaGroups.genre:
        set = db.select("select DISTINCT genre from '${sourceID}'");

      case MediaGroups.albumArtest:
        set = db.select("select DISTINCT albumArtest from '${sourceID}'");
    }


    for (var item in set)
    {

      //Switch on group filter foreach
      switch (source.mediaGroup)
      {


        case MediaGroups.album:
          set = db.select("select DISTINCT album from '${sourceID}'");
          name = item["album"];

        case MediaGroups.artest:
          set = db.select("select DISTINCT artest from '${sourceID}'");
          name = item["artest"];


        case MediaGroups.year:
          set = db.select("select DISTINCT year from '${sourceID}'");
          name = item["year"];

        case MediaGroups.genre:
          set = db.select("select DISTINCT genre from '${sourceID}'");
          name = item["genre"];

        case MediaGroups.albumArtest:
          set = db.select("select DISTINCT albumArtest from '${sourceID}'");
          name = item["albumArtest"];
      }
      String secondaryLabel = "";

      // SWITCH ON Group filter

      switch (source.secondaryLabel)
      {

        case MediaLabels.artestCount:
          // TODO: Handle this case.
        case MediaLabels.albumCount:
          // TODO: Handle this case.
        case MediaLabels.totalTime:
          // TODO: Handle this case.
        case MediaLabels.songCount:
          // TODO: Handle this case.
        case MediaLabels.yearRange:
          // TODO: Handle this case.
        case MediaLabels.genreCount:
          // TODO: Handle this case.
        case MediaLabels.albumArtestCount:
          // TODO: Handle this case.
        case MediaLabels.composerCount:
          // TODO: Handle this case.
        case MediaLabels.discNumbers:
          // TODO: Handle this case.

          secondaryLabel = "TEMP";
          mediaGroups.add(MediaGroup(secondaryLabel, name: name));
      }



      print(item['album']);
    }
    db.dispose();
    return mediaGroups;
  }
}