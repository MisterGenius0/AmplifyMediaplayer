import 'dart:io';
import 'dart:typed_data';

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
      metadata.title?.replaceAll("'", ""),
      metadata.durationMs,
      metadata.artist?.replaceAll("'", ""),
      metadata.album?.replaceAll("'", ""),
      metadata.albumArtist?.replaceAll("'", ""),
      metadata.trackNumber,
      metadata.trackTotal,
      metadata.discNumber,
      metadata.discTotal,
      metadata.year,
      metadata.genre?.replaceAll("'", ""),
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
    late  ResultSet mainResult;

    switch (source.mediaGroup)
    {

      case MediaGroups.album:
        mainResult = db.select("select DISTINCT album from '${sourceID}'");

      case MediaGroups.artist:
        mainResult = db.select("select DISTINCT artist from '${sourceID}'");

      case MediaGroups.year:
        mainResult = db.select("select DISTINCT year from '${sourceID}'");

      case MediaGroups.genre:
        mainResult = db.select("select DISTINCT genre from '${sourceID}'");

      case MediaGroups.albumArtest:
        mainResult = db.select("select DISTINCT albumArtist from '${sourceID}'");
    }

//select DISTINCT picture from "All Music_2023-09-11 04:59:12.484414Z_media" WHERE album ='FTL'
    for (var item in mainResult)
    {
      late  ResultSet pictureResult;
      List<Uint8List> pictures = [];
      String name = "";

      //Switch on group filter foreach
      switch (source.mediaGroup)
      {
      //

        case MediaGroups.album:
          pictureResult = db.select("select DISTINCT picture from '${sourceID}' WHERE album ='${item["album"]}' ORDER BY random() limit 4");
          print("select DISTINCT picture from '${sourceID}' WHERE album ='${item["album"]}'");
          name = item["album"] ?? "NULL";

        case MediaGroups.artist:
      //set2 = db.select("select DISTINCT artist from '${sourceID}'");
          pictureResult = db.select("select DISTINCT picture from '${sourceID}' WHERE artist ='${item["artist"]}' ORDER BY random() limit 4");
          name = item["artist"]  ?? "NULL";


        case MediaGroups.year:
          pictureResult = db.select("select DISTINCT picture from '${sourceID}' WHERE year ='${item["year"]}' ORDER BY random() limit 4");
          name = item["year"]  ?? "NULL";

        case MediaGroups.genre:
          pictureResult = db.select("select DISTINCT picture from '${sourceID}' WHERE genre ='${item["genre"]}' ORDER BY random() limit 4");
          name = item["genre"]  ?? "NULL";

        case MediaGroups.albumArtest:
          pictureResult = db.select("select DISTINCT picture from '${sourceID}' WHERE albumArtist ='${item["albumArtist"]}' ORDER BY random() limit 4");
          name = item["albumArtist"]  ?? "NULL";
      }
      String secondaryLabel = "";

      // SWITCH ON Group filter

      switch (source.secondaryLabel)
      {

        case MediaLabels.artistCount:
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
      }



      for(var picture in pictureResult)
        {
          if(picture["picture"] != null){
            pictures.add(picture["picture"]);
          }

        }


      secondaryLabel = "TEMP";
      mediaGroups.add(MediaGroup(name: name, secondaryLabel: secondaryLabel, pictures: pictures));
    }
    db.dispose();
    return mediaGroups;
  }
}