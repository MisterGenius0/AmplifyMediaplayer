import 'dart:io';
import 'dart:typed_data';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/widgets.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

class MediaDBModel extends BaseDBModel {
  MediaDBModel();

  @override
  String get dbName => "Media cache";

  Future<void> deleteMediaTable(MediaSource source) async {
    sqflite.Database db = await loadDB();
    db.transaction((txn) async{
      txn.execute('''
    DROP TABLE '${source.sourceID}';''');
    });

  }

  Future<void> addMediaToTable(
      String sourceID, Metadata metadata, Directory filepath) async {
    sqflite.Database db = await loadDB();
    db.transaction((txn) async {

      print(metadata);
      txn.rawInsert('''INSERT INTO  '${sourceID}' 
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
    });
    print("Saved: ${metadata.title}");
  }

  //Private functions
  Future<void> createMediaTable(String sourceID) async {
    sqflite.Database db = await loadDB();

    //TODO block users from entering ' single comma
    db.transaction((txn) async {
      txn.execute('''
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
    });
  }

  Future<List<Map<String, Object?>>> getMediaGroups(MediaSource source)
  async {
    sqflite.Database db = await loadDB();
    late List<Map<String, Object?>> mainResult;
    String sourceID = source.sourceID;

    return db.transaction((txn) async {
          return mainResult = await txn.rawQuery("select DISTINCT ${source.mediaGroup.name} from '${sourceID}'");
    }
    );
  }
  Future<List<MediaGroup>> getGroups(
      MediaSource source, String sourceID) async {
    sqflite.Database db = await loadDB();
    createMediaTable(sourceID);
    List<MediaGroup> mediaGroups = [];
    late List<Map<String, Object?>> mainResult;

    mainResult = await getMediaGroups(source);
    for (var item in mainResult) {
      String name = "";

      await db.transaction((txn2) async {
            name = (item[source.mediaGroup.name].toString() ?? " ");
      });

      //Switch on group filter foreach

      String secondaryLabel = "TEMP";

      mediaGroups.add(MediaGroup(
          mediaSource: source, name: name, secondaryLabel: secondaryLabel));
    }
    return mediaGroups;
  }

  Future<List<ImageProvider>> GetGroupImage(MediaGroup mediaGroup) async {
    List<Map<String, Object?>> pictureResult = [];
    List<ImageProvider> pictures = [];
    MediaSource source = mediaGroup.mediaSource;
    sqflite.Database db = await loadDB();

    await db.transaction((txn) async {
      ///Get pictures from query

      pictureResult = await txn.rawQuery("select DISTINCT picture from '${source.sourceID}' WHERE ${source.mediaGroup.name} ='${mediaGroup.name}' ORDER BY random() limit 4");

      //add pictures to list to be returned
      for (var picture in pictureResult) {
        if (picture["picture"] != null) {
          pictures.add(Image.memory(picture["picture"] as Uint8List).image);
        }
      }
      return pictures;
    }
    );
    return pictures;
  }
}
