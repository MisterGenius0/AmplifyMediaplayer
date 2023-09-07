import 'dart:convert';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/base_db_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/views/widgets/item%20grid/source_widget.dart';
import 'package:sqlite3/src/result_set.dart';

class SourceDBModel extends baseDBModel
{
  SourceDBModel({required super.db});

  @override
  String get dbName => "Source";


  //Sources

  void createSourceTable()
  {
    db.execute('''
    CREATE TABLE  IF NOT EXISTS 'sources' (
        id INTEGER NOT NULL PRIMARY KEY,  
        sourceName TEXT,
        mediaTableName TEXT,
        mediaGroup TEXT,
        primaryLabel TEXT,
        secondaryLabel TEXT,
        sourceDirectorys BLOB
    ); ''');
  }

  void addSourceToDB(MediaSource source, MediaDBModel mediaDBModel)
  {
    mediaDBModel.createMediaTable(source.sourceID);
    createSourceTable();

    final stmt = db.prepare('''INSERT INTO sources (
      sourceName,
      mediaTableName,
       mediaGroup,
       primaryLabel,
       secondaryLabel,
       sourceDirectorys
       ) VALUES (?,?,?,?,?,?)''');

    stmt.execute([
      source.sourceName,
      source.sourceID,
      source.mediaGroup.name,
      source.primaryLabel.name,
      source.secondaryLabel.name,
      source.sourceDirectorys.join(",")
    ]);
  }

  List<MediaSource> getAllSources()
  {
    createSourceTable();
    List<MediaSource> sources = [];

    final ResultSet set = db.select("SELECT * FROM sources");

    for (var item in set)
      {
        MediaSource mediaSource = MediaSource(sourceName: item['sourceName'],
            mediaGroup: MediaGroups.values.byName(item['mediaGroup']),
            primaryLabel: MediaLabels.values.byName(item['primaryLabel']),
            secondaryLabel: MediaLabels.values.byName(item['secondaryLabel']),
            sourceDirectorys:  item['secondaryLabel'].toString().split(","));
        sources.add(mediaSource);
      }
    return sources;
  }
}
