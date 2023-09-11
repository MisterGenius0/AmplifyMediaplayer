import 'dart:io';

import 'package:amplify/models/database/base_db_model.dart';
import 'package:flutter/cupertino.dart';
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
    DROP TABLE '${source.sourceID}_media';''');

    db.dispose();
  }

  Future<void> addMediaToTable(String sourceID, Metadata metadata, Directory filepath)
  async {
    Database db = await  loadDB();
    final stmt = db.prepare('''INSERT INTO  '${sourceID}_media' 
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
    CREATE TABLE  IF NOT EXISTS '${sourceID}_media' (
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
}