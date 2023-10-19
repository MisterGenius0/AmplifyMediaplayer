import 'dart:io';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;
import 'package:sqlite3/sqlite3.dart';

class MediaDBModel extends BaseDBModel {
  MediaDBModel();

  @override
  // TODO: implement dbName
  String get dbName => "Media cache";

  Future<void> deleteMediaTable(MediaSource source) async {
    sqflite.Database db = await loadDB();
    db.execute('''
    DROP TABLE '${source.sourceID}';''');
  }

  Future<void> addMediaToTable(
      String sourceID, Metadata metadata, Directory filepath) async {
    sqflite.Database db = await loadDB();
    final stmt = db.rawInsert('''INSERT INTO  '${sourceID}' 
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
        ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?,?)''', [
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
  }

  //Private functions
  Future<void> createMediaTable(String sourceID) async {
    sqflite.Database db = await loadDB();
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
  }

// TODO finish this function to return grups names
  Future<List<MediaGroup>> getGroups(
      MediaSource source, String sourceID) async {
    sqflite.Database db = await loadDB();
    createMediaTable(sourceID);
    List<MediaGroup> mediaGroups = [];
    late List<Map<String, Object?>> mainResult = [];

    await db.transaction((txn) async {
      switch (source.mediaGroup) {
        case MediaGroups.album:
          mainResult =
              await txn.rawQuery("select DISTINCT album from '${sourceID}'");

        case MediaGroups.artist:
          mainResult =
              await txn.rawQuery("select DISTINCT artist from '${sourceID}'");

        case MediaGroups.year:
          mainResult =
              await txn.rawQuery("select DISTINCT year from '${sourceID}'");

        case MediaGroups.genre:
          mainResult =
              await txn.rawQuery("select DISTINCT genre from '${sourceID}'");

        case MediaGroups.albumArtest:
          mainResult = await txn
              .rawQuery("select DISTINCT albumArtist from '${sourceID}'");
      }
    });

    sqflite.Database db2 = await loadDB();
//select DISTINCT picture from "All Music_2023-09-11 04:59:12.484414Z_media" WHERE album ='FTL'
    for (var item in mainResult) {
      late List<Map<String, Object?>> pictureResult = [];
      List<ImageProvider> pictures = [];
      String name = "";

      await db2.transaction((txn2) async {
        switch (source.mediaGroup) {
          case MediaGroups.album:
            pictureResult = await txn2.rawQuery(
                "select DISTINCT picture from '${sourceID}' WHERE album ='${item["album"]}' ORDER BY random() limit 4");
            name = (item["album"] ?? "NULL") as String;

          case MediaGroups.artist:
            //set2 = db.select("select DISTINCT artist from '${sourceID}'");
            pictureResult = await txn2.rawQuery(
                "select DISTINCT picture from '${sourceID}' WHERE artist ='${item["artist"]}' ORDER BY random() limit 4");
            name = (item["artist"] ?? "NULL") as String;

          case MediaGroups.year:
            pictureResult = await txn2.rawQuery(
                "select DISTINCT picture from '${sourceID}' WHERE year ='${item["year"]}' ORDER BY random() limit 4");
            name = (item["year"] ?? "NULL") as String;

          case MediaGroups.genre:
            pictureResult = await txn2.rawQuery(
                "select DISTINCT picture from '${sourceID}' WHERE genre ='${item["genre"]}' ORDER BY random() limit 4");
            name = (item["genre"] ?? "NULL") as String;

          case MediaGroups.albumArtest:
            pictureResult = await txn2.rawQuery(
                "select DISTINCT picture from '${sourceID}' WHERE albumArtist ='${item["albumArtist"]}' ORDER BY random() limit 4");
            name = (item["albumArtist"] ?? "NULL") as String;
        }
      });

      //Switch on group filter foreach

      String secondaryLabel = "";

      // SWITCH ON Group filter

      switch (source.secondaryLabel) {
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

      for (var picture in pictureResult) {
        if (picture["picture"] != null) {
          pictures.add(Image.memory(picture["picture"] as Uint8List).image);
        }
      }

      secondaryLabel = "TEMP";
      mediaGroups.add(MediaGroup(
          name: name, secondaryLabel: secondaryLabel, images: pictures));
    }
    return mediaGroups;
  }
}
