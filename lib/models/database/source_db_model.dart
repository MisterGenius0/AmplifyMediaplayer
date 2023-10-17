import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as sqflite;

class SourceDBModel extends BaseDBModel {
  SourceDBModel();

  @override
  String get dbName => "Source";

  //Sources

  Future<void> deleteSource(MediaSource source) async {
    sqflite.Database db = await loadDB();
    MediaDBModel mediaDBModel = MediaDBModel();

    mediaDBModel.deleteMediaTable(source);

   await db.transaction((txn) async {
     try {
       txn.rawQuery('''
    DELETE FROM Sources WHERE sourceID = '${source.sourceID}';''');
     }
     catch(e)
     {
       if (kDebugMode) {
         print(e);
       }
     }
   });
  }

  Future<void> createSourceTable() async {
    sqflite.Database db = await loadDB();
    await db.transaction((txn) async {
      try{
        txn.execute('''
    CREATE TABLE  IF NOT EXISTS 'Sources' (
        id INTEGER NOT NULL PRIMARY KEY,  
        sourceName TEXT,
        sourceID TEXT,
        mediaGroup TEXT,
        primaryLabel TEXT,
        secondaryLabel TEXT,
        sourceDirectorys BLOB
    ); ''');
      }
      catch(e){
        if (kDebugMode) {
          print(e);
        }
      }

    });

  }

  //TODO finish refresh source metadata function
  Future<void> refreshSourceData(String sourceID )  async {
    MediaDBModel mediaDBModel = MediaDBModel();
    sqflite.Database db = await mediaDBModel.loadDB();

    //create media table if not exists
    mediaDBModel.createMediaTable(sourceID);

    await db.transaction((txn) async {
      List<Map<String, Object?>> result = await txn.rawQuery('''SELECT id FROM '${sourceID}' ''');

      if (result.isEmpty)
        {
          sqflite.Database sourceDB = await loadDB();

          sourceDB.transaction((txn2) async {

            List<Map<String, Object?>> sourceResults = await txn2.rawQuery('''SELECT * FROM Sources WHERE sourceID ='$sourceID' ''');

            for (var sourceResult in sourceResults) {
              MediaSource mediaSource = MediaSource(
                sourceName: sourceResult['sourceName'] as String,
                mediaGroup: MediaGroups.values.byName(sourceResult['mediaGroup'] as String),
                primaryLabel:
                MediaLabels.values.byName(sourceResult['primaryLabel'] as String),
                secondaryLabel:
                MediaLabels.values.byName(sourceResult['secondaryLabel'] as String),
                sourceDirectorys: sourceResult['sourceDirectorys'].toString().split(","));
              mediaSource.sourceID = (sourceResult['sourceID'] as String);

              mediaSource.refreshMedia();
            }
          });
        }
      else
        {
          print("${sourceID} has data");
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
       sourceDirectorys
       ) VALUES (?,?,?,?,?,?)''', [
          source.sourceName.replaceAll("'", ""),
          source.sourceID,
          source.mediaGroup.name,
          source.primaryLabel.name,
          source.secondaryLabel.name,
          source.sourceDirectorys.join(",")
        ]);
      }
      catch(e)
      {
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
      try{
        result = await txn.rawQuery("SELECT * FROM Sources");
      }
      catch (e)
      {
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
          MediaLabels.values.byName(item['primaryLabel'] as String),
          secondaryLabel:
          MediaLabels.values.byName(item['secondaryLabel'] as String),
          sourceDirectorys: item['sourceDirectorys'].toString().split(","));
      mediaSource.sourceID = (item['sourceID'] as String);
      sources.add(mediaSource);
    }
    return sources;
  }

  Future<List<ImageProvider>> getSourceImages(String sourceID) async {
    MediaDBModel mediaDBModel = MediaDBModel();

    await createSourceTable();
    await  refreshSourceData(sourceID);
    if (ServicesBinding.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(
          ServicesBinding.rootIsolateToken!);
    }

    sqflite.Database dB = await mediaDBModel.loadDB();
    late List<Map<String, Object?>> result = [];



   await  dB.transaction((txn) async{
      result = await txn.rawQuery("select distinct picture from '$sourceID'  ORDER BY random() limit 4");
    });

    List<ImageProvider> pictures = [];
    for (final picture in result) {
      if (picture["picture"] != null) {
        ImageProvider data =
            (Image.memory(picture["picture"] as Uint8List).image);
        pictures.add(data);
      }
    }
    print(pictures);
    return pictures;
  }
}
