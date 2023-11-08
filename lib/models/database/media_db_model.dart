import 'dart:io';
import 'dart:typed_data';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/widgets.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

import '../media_Model.dart';

class MediaDBModel extends BaseDBModel {
  MediaDBModel();

  @override
  String get dbName => "Media cache";

  Future<void> deleteMediaTable(String sourceID) async {
    sqflite.Database db = await loadDB();
    db.transaction((txn) async{
      txn.execute('''
    DROP TABLE '${sourceID}';''');
    });

  }

  Future<void> addMediaToTable(
      String sourceID, Metadata metadata, Directory filepath) async {
    sqflite.Database db = await loadDB();
    await createMediaTable(sourceID);

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
        filePath TEXT
    ); ''');
    });
  }

  Future<List<Media>> getMediaFromGroup(MediaGroup group)
  async {
    String sourceID = group.mediaSource.sourceID;
    sqflite.Database db = await loadDB();
    createMediaTable(sourceID);

    List<Media> medias = [];
    MediaSource source = group.mediaSource;

    //Get all medias in DB
    return db.transaction((txn) async {

      List<Map<String, Object?>> result  = await txn.rawQuery("select title, durationMs, trackNumber, discNumber, filePath from '$sourceID' WHERE ${source.mediaGroup.name} ='${group.name}' ORDER BY trackNumber ASC");

      //Add to array and return final array
      for (var media in result)
        {
          Media newMedia = Media(mediaPath: Directory(media['filePath'].toString()), iD: sourceID, mediaName: media['title'].toString(), secondaryLabel: media['durationMs'].toString(), trackNumber: media["trackNumber"] as int, discNumber: media["discNumber"] as int, group: group);
          medias.add(newMedia);
        }

      return medias;
    }
    );
  }

  Future<List<Map<String, Object?>>> getMediaGroups(MediaSource source)
  async {
    sqflite.Database db = await loadDB();
    String sourceID = source.sourceID;

    return db.transaction((txn) async {
          return await txn.rawQuery("select DISTINCT ${source.mediaGroup.name} from '${sourceID}' ORDER BY ${source.mediaGroup.name} ASC");
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


  Future<List<ImageProvider>> getGroupImage(MediaGroup mediaGroup) async {
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
