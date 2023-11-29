import 'dart:convert';
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

  //gets a list of media from a provided group
  Future<List<Media>> getMediaFromGroup(MediaGroup group)
  async {
    String sourceID = group.mediaSource.sourceID;
    sqflite.Database db = await loadDB();
    createMediaTable(sourceID);

    List<Media> medias = [];
    MediaSource source = group.mediaSource;

    //Get all medias in DB
    return db.transaction((txn) async {

      List<Map<String, Object?>> result  = await txn.rawQuery("select title, durationMs, trackNumber, discNumber, filePath from '$sourceID' WHERE ${source.mediaGroup.name} ='${group.name}' ORDER BY UPPER(album), discNumber, trackNumber, UPPER(title) ASC");

      //Add to array and return final array
      for (var media in result)
        {
          Media newMedia = Media(mediaPath: Directory(media['filePath'].toString()), iD: sourceID, mediaName: media['title'].toString(), secondaryLabel: media['durationMs'].toString(), trackNumber: media["trackNumber"] != null ?  media["trackNumber"] as int : null, discNumber: media["discNumber"] != null ?  media["discNumber"] as int : null, album: media['album'].toString(), group: group);
          medias.add(newMedia);
        }

      return medias;
    }
    );
  }

  //gets a list of media from a provided group
  Future<List<List<List<Map<Media, int>>>>> getMediaFromGroupSorted(MediaGroup group)
  async {
    String sourceID = group.mediaSource.sourceID;
    sqflite.Database db = await loadDB();
    createMediaTable(sourceID);

    List<List<List<Map<Media, int>>>> medias = [];
    MediaSource source = group.mediaSource;

    //Get all medias in DB
    return db.transaction((txn) async {

      List<Map<String, Object?>> result  = await txn.rawQuery("select title, durationMs, album, trackNumber, discNumber, filePath from '$sourceID' WHERE ${source.mediaGroup.name} ='${group.name}' ORDER BY UPPER(album), discNumber, trackNumber, UPPER(title) ASC");

      String? album;
      int? discNumber;

      //Add to array and return final array
      int index = 0;
      for (var media in result) {
        Media newMedia = Media(
            mediaPath: Directory(media['filePath'].toString()),
            iD: sourceID,
            mediaName: media['title'].toString(),
            secondaryLabel: media['durationMs'].toString(),
            trackNumber: media["trackNumber"] != null
                ? media["trackNumber"] as int
                : null,
            discNumber: media["discNumber"] != null
                ? media["discNumber"] as int
                : null,
            album: media['album'].toString(),
            group: group);
        if (newMedia.album == album) {

          if (newMedia.discNumber == discNumber) {

            //new media in same album and disc
            medias.last.last.add({newMedia : index});

          }
          else {
            //Same album with new disc
            medias.last.add([{newMedia : index}]);
          }
      }
        else {
          //New Album with new disc
            medias.add([[{newMedia : index}]]);
          }
        album = newMedia.album;
        print(newMedia.album);
        print(newMedia.discNumber);
        discNumber = newMedia.discNumber;
        index++;
    }
      print(medias);

      return medias;
    }
    );
  }

  //gets the images from a provided group
  Future<List<ImageProvider>> getMediaImages(Media media) async {
    List<Map<String, Object?>> pictureResult = [];
    List<ImageProvider> pictures = [];
    MediaSource source = media.group!.mediaSource;
    sqflite.Database db = await loadDB();

    await db.transaction((txn) async {
      ///Get pictures from query

      pictureResult = await txn.rawQuery("select DISTINCT picture from '${source.sourceID}' WHERE title ='${media.mediaName}' AND ${source.mediaGroup.name} ='${media.group!.name}' ORDER BY random() limit 4");

      print("select DISTINCT picture from '${source.sourceID}' WHERE title ='${media.mediaName}' AND ${source.mediaGroup.name} ='${media.group!.name}' ORDER BY random() limit 4");

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

  //gets a group from a provided source
  Future<List<Map<String, Object?>>> getMediaGroups(MediaSource source)
  async {
    sqflite.Database db = await loadDB();
    String sourceID = source.sourceID;

    return db.transaction((txn) async {
          return await txn.rawQuery("select DISTINCT ${source.mediaGroup.name} from '${sourceID}' ORDER BY UPPER(${source.mediaGroup.name}) ASC");
    }
    );
  }

//Returns a group from a provided source
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


  //gets the images from a provided group
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
