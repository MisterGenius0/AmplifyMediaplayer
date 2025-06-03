import 'package:amplify/models/source_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

import 'base_db.dart';
import 'image_db.dart';
import 'media_db.dart';

class SourceDBModel extends BaseDBModel {
  SourceDBModel();

  @override
  String get dbName => "Source";

  //Sources
  Future<void> deleteSource(String sourceID) async {
    sqflite.Database db = await loadDB();
    MediaDBModel mediaDBModel = MediaDBModel();

    mediaDBModel.deleteMediaTable(sourceID);

    await db.transaction((txn) async {
      try {
        txn.rawQuery('''
    DELETE FROM Sources WHERE sourceID = '$sourceID';''');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  Future<void> createSourceTable() async {
    sqflite.Database db = await loadDB();
    await db.transaction((txn) async {
      try {
        txn.execute('''
    CREATE TABLE  IF NOT EXISTS 'Sources' (
        id INTEGER NOT NULL PRIMARY KEY,  
        sourceName TEXT,
        sourceID TEXT,
        mediaGroup TEXT,
        primaryLabel TEXT,
        secondaryLabel TEXT,
        sourceDirectorys BLOB,
        fileCount TEXT
    ); ''');
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  //Refresh and rebuild media cache if its missing
  Future<void> refreshSourceData(BuildContext context) async {
    MediaDBModel mediaDBModel = MediaDBModel();

    //create media table if not exists
      sqflite.Database sourceDB = await loadDB();
    await createSourceTable();

    sqflite.Database mediaDB = await mediaDBModel.loadDB();
      await sourceDB.transaction((txn) async {
        List<Map<String, Object?>> sourceResults =
            await txn.rawQuery('''SELECT sourceID FROM sources''');

        for (var sourceResult in sourceResults) {
          List<Map<String, Object?>> sourceDatas = await txn.rawQuery(
              '''SELECT * FROM Sources WHERE sourceID ='${sourceResult['sourceID']}' ''');
          for (var sourceData in sourceDatas) {
            try {
              debugPrint("Checking: '${sourceData['sourceName']}' ");
              await mediaDB.transaction((txn2) async {

                //TODO finish implementing total file count

                await txn2.rawQuery('''SELECT id FROM '${sourceData['sourceID']}' ''');
              });
            } catch (e) {
              debugPrint(e.toString());
              debugPrint('''SELECT id FROM '${sourceData['sourceID']}' ''');

              debugPrint("error occurred... refreshing: '${sourceData['sourceName']}' ");
              await mediaDBModel.createMediaTable(sourceData['sourceID'].toString());
              MediaSource mediaSource = MediaSource(
                  sourceName: sourceData['sourceName'] as String,
                  mediaGroup: MediaGroups.values
                      .byName(sourceData['mediaGroup'] as String),
                  primaryLabel: MediaGroupLabels.values
                      .byName(sourceData['primaryLabel'] as String),
                  secondaryLabel: MediaGroupLabels.values
                      .byName(sourceData['secondaryLabel'] as String),
                  sourceDirectorys:
                      sourceData['sourceDirectorys'].toString().split(","));
              mediaSource.sourceID = (sourceData['sourceID'] as String);
          //   mediaSource.refreshMedia();
              addSourceToDB(mediaSource);
            }
          }
        }
      });
  }

  Future<void> addSourceToDB(MediaSource source) async {
    sqflite.Database db = await loadDB();
    MediaDBModel mediaDBModel = MediaDBModel();

    mediaDBModel.createMediaTable(source.sourceID);
    await createSourceTable();

    await db.transaction((txn) async {
      try {
        txn.rawInsert('''INSERT INTO Sources (
      sourceName,
      sourceID,
       mediaGroup,
       primaryLabel,
       secondaryLabel,
       sourceDirectorys,
       fileCount
       ) VALUES (?,?,?,?,?,?,?)''', [
          source.sourceName.replaceAll("'", ""),
          source.sourceID,
          source.mediaGroup.name,
          source.primaryLabel.name,
          source.secondaryLabel.name,
          source.sourceDirectorys.join(","),
          source.fileCount.toString(),
        ]);
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });
  }

  Future<List<MediaSource>> getAllSources() async {
    sqflite.Database dB = await loadDB();

    await createSourceTable();
    List<MediaSource> sources = [];
    late List<Map<String, Object?>> result = [];

    await dB.transaction((txn) async {
      try {
        result = await txn.rawQuery("SELECT * FROM sources ORDER BY UPPER(sourceName) ASC");
      } catch (e) {
        if (kDebugMode) {
          print(e);
        }
      }
    });

    for (var item in result) {
      MediaSource mediaSource = MediaSource(
          sourceName: item['sourceName'] as String,
          mediaGroup: MediaGroups.values.byName(item['mediaGroup'] as String),
          primaryLabel:
              MediaGroupLabels.values.byName(item['primaryLabel'] as String),
          secondaryLabel:
              MediaGroupLabels.values.byName(item['secondaryLabel'] as String),
          sourceDirectorys: item['sourceDirectorys'].toString().split(","));
      mediaSource.sourceID = (item['sourceID'] as String);
      sources.add(mediaSource);
    }


    return sources;
  }

  Future<List<ImageProvider>> getSourceImages(String sourceID) async {
    MediaDBModel mediaDBModel = MediaDBModel();
     sqflite.Database dB = await mediaDBModel.loadDB();

    ImageDBModel imageDBModel = ImageDBModel();
    List<ImageProvider> pictures = [];

    List<Map<String, Object?>> imageIDs = [];

    await dB.transaction((txn) async {
      ///Get pictures from query

      imageIDs = await txn.rawQuery("select DISTINCT imageID from '$sourceID' ORDER BY random() limit 4");

      for (var imageID in imageIDs) {
        if (imageID["imageID"] != null) {
          List<Map<String, Object?>> filePath = await txn.rawQuery('''SELECT filePath FROM '$sourceID' WHERE imageID =${imageID["imageID"]} ''');
          Uint8List? imageData = await imageDBModel.findImageByID(imageID["imageID"] as int, filePath.first["filePath"] as String);
          pictures.add(Image.memory(imageData!).image);
        }
      }
    });
        return pictures;
  }

    // await createSourceTable();
    // if (ServicesBinding.rootIsolateToken != null) {
    //   BackgroundIsolateBinaryMessenger.ensureInitialized(
    //       ServicesBinding.rootIsolateToken!);
    // }
    //
    // sqflite.Database dB = await mediaDBModel.loadDB();
    // late List<Map<String, Object?>> result = [];
    //
    // await dB.transaction((txn) async {
    //   result = await txn.rawQuery(
    //       "select distinct imageID from '$sourceID'  ORDER BY random() limit 4");
    // });
    //
    // List<ImageProvider> pictures = [];
    // for (final picture in result) {
    //   if (picture["picture"] != null) {
    //     ImageProvider data =
    //         (Image.memory(picture["picture"] as Uint8List).image);
    //     pictures.add(data);
    //   }
    // }
}
