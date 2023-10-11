import 'dart:isolate';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:sqlite3/sqlite3.dart' as sqlite3;
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as newDB;

class SourceDBModel extends BaseDBModel {
  SourceDBModel();

  @override
  String get dbName => "Source";


  //Sources

  Future<void> deleteSource(MediaSource source) async {
    sqlite3.Database db = await loadDB();
    MediaDBModel mediaDBModel = MediaDBModel();

    mediaDBModel.deleteMediaTable(source);

    db.execute('''
    DELETE FROM sources WHERE sourceID = '${source.sourceID}';''');
    db.dispose();
  }

  Future<void> createSourceTable() async {
    sqlite3.Database db = await loadDB();
    ;
    db.execute('''
    CREATE TABLE  IF NOT EXISTS 'sources' (
        id INTEGER NOT NULL PRIMARY KEY,  
        sourceName TEXT,
        sourceID TEXT,
        mediaGroup TEXT,
        primaryLabel TEXT,
        secondaryLabel TEXT,
        sourceDirectorys BLOB
    ); ''');

    db.dispose();
  }

  Future<void> addSourceToDB(MediaSource source) async {
    sqlite3.Database db = await loadDB();
    MediaDBModel mediaDBModel = MediaDBModel();

    mediaDBModel.createMediaTable(source.sourceID);
    createSourceTable();

    final stmt = db.prepare('''INSERT INTO sources (
      sourceName,
      sourceID,
       mediaGroup,
       primaryLabel,
       secondaryLabel,
       sourceDirectorys
       ) VALUES (?,?,?,?,?,?)''');

    stmt.execute([
      source.sourceName.replaceAll("'", ""),
      source.sourceID,
      source.mediaGroup.name,
      source.primaryLabel.name,
      source.secondaryLabel.name,
      source.sourceDirectorys.join(",")
    ]);
    db.dispose();
  }

  Future<List<MediaSource>> getAllSources() async {
    sqlite3.Database db = await loadDB();
    createSourceTable();
    List<MediaSource> sources = [];

    final sqlite3.ResultSet set = db.select("SELECT * FROM sources");

    for (var item in set) {
      MediaSource mediaSource = MediaSource(sourceName: item['sourceName'],
          mediaGroup: MediaGroups.values.byName(item['mediaGroup']),
          primaryLabel: MediaLabels.values.byName(item['primaryLabel']),
          secondaryLabel: MediaLabels.values.byName(item['secondaryLabel']),
          sourceDirectorys: item['sourceDirectorys'].toString().split(","));
      mediaSource.sourceID = (item['sourceID']);
      sources.add(mediaSource);
    }
    db.dispose();
    return sources;
  }


  Future<List<ImageProvider>> getSourceImages(
      String sourceID) async {
    MediaDBModel mediaDBModel = MediaDBModel();


    createSourceTable();
    if (ServicesBinding.rootIsolateToken != null) {
      BackgroundIsolateBinaryMessenger.ensureInitialized(
          ServicesBinding.rootIsolateToken!);
    }

    newDB.Database MediaDB = await mediaDBModel.loadDBNew();
    late List<Map<String, Object?>> pictureResult;
 //   "picture from '${sourceID}'  ORDER BY random() limit 4");
    pictureResult = await MediaDB.rawQuery("select distinct picture from '$sourceID'  ORDER BY random() limit 4");
    final resultPort = ReceivePort();

    List<ImageProvider> pictures = [];
    for (final picture in pictureResult) {
      if (picture["picture"] != null) {
        ImageProvider data = (Image
            .memory(picture["picture"] as Uint8List)
            .image);
        pictures.add(data);
      }
    }
    return pictures;
  }
}


