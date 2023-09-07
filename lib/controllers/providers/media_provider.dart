import 'dart:io';

import 'package:amplify/models/database/blob_db_model.dart';
import 'package:amplify/models/database/settings_db_model.dart';
import 'package:amplify/models/database/source_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:amplify/models/Source_model.dart';
import 'package:sqlite3/sqlite3.dart';

import 'package:amplify/models/database/media_db_model.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();
  late final SharedPreferences prefs;

  List<MediaSource> sources = [];

  List<String> _sourcesIDs = [];

  //DB
  late Database mediaDB = sqlite3.openInMemory();
  late Database settingsDB = sqlite3.openInMemory();
  late Database blobDB = sqlite3.openInMemory();
  late Database sourceDB = sqlite3.openInMemory();

  late MediaDBModel mediaDBModel = MediaDBModel(db: mediaDB);
  late SettingsDBModel settingsDBModel = SettingsDBModel(db: mediaDB);
  late BlobDBModel blobDBModel = BlobDBModel(db: mediaDB);
  late SourceDBModel sourceDBModel = SourceDBModel(db: mediaDB);


  //KEYS
  final String _sourceIDKey = "SourceID";

  final String _sourceNameKey = "_Name";

  final String _sourceMediaGroupKey = "_Group";

  final String _sourcePrimaryLabelKey = "_PrimaryLabel";

  final String _sourceSecondaryLabelKey = "_SecondaryLabel";

  final String _sourceDirectoryKey = "_SourceDirectory";

  Future<void> loadData(BuildContext context) async {
    prefs = await SharedPreferences.getInstance();

mediaDBModel = MediaDBModel(db: mediaDB);
settingsDBModel = SettingsDBModel(db: mediaDB);
blobDBModel = BlobDBModel(db: mediaDB);
sourceDBModel = SourceDBModel(db: mediaDB);

    //load media DB
    mediaDB =  await mediaDBModel.loadDB();
    settingsDB = await settingsDBModel.loadDB();
    blobDB = await blobDBModel.loadDB();
    sourceDB = await sourceDBModel.loadDB();


    // List<String>? sourceIDs = prefs.getStringList(_sourceIDKey);
    //
    // if (sourceIDs != null) {
    //   for (var sourceID in sourceIDs) {
    //     String? sourceName =
    //         prefs.getString(sourceID + _sourceNameKey) ?? "NULL";
    //
    //     String? mediaGroup =
    //         prefs.getString(sourceID + _sourceMediaGroupKey) ?? "NULL";
    //
    //     String? primaryLabel =
    //         prefs.getString(sourceID + _sourcePrimaryLabelKey) ?? "NULL";
    //
    //     String? secondaryLabel =
    //         prefs.getString(sourceID + _sourceSecondaryLabelKey) ?? "NULL";
    //
    //     List<String>? sourceDirectorys =
    //         prefs.getStringList(sourceID + _sourceDirectoryKey) ?? [];
    //
    //
    //     _sourcesIDs.add(sourceID);
    //
    //     MediaSource createdSource = MediaSource(
    //         sourceName: sourceName,
    //         mediaGroup: MediaGroups.values.byName(mediaGroup),
    //         primaryLabel: MediaLabels.values.byName(primaryLabel),
    //         secondaryLabel: MediaLabels.values.byName(secondaryLabel),
    //         sourceDirectorys: sourceDirectorys);
    //     createdSource.sourceID = sourceID;
    //
    //     createdSource.loadSourceData();
    //
    //     sources.add(createdSource);
    //     print("Loaded: $sourceID");
    //   }
    // }

    print("Finished loading");
    notifyListeners();
  }

  Future<void> deleteSource(MediaSource source) async {
    if(source.sourceID != "")
      {
        String sourceID = source.sourceID;
        await prefs.remove(sourceID);

        await prefs.remove(sourceID + _sourceNameKey);
        await prefs.remove(sourceID + _sourceMediaGroupKey);
        await prefs.remove(sourceID + _sourcePrimaryLabelKey);
        await prefs.remove(sourceID + _sourceSecondaryLabelKey);
        await prefs.remove(sourceID + _sourceDirectoryKey);

      }
  }

  Future<void> saveSource(MediaSource source) async {
    sourceDBModel.addSourceToDB(source, mediaDBModel);


    // if(source.sourceID != "")
    //   {
    //     _sourcesIDs.contains(source.sourceID) ? "" : _sourcesIDs.add(source.sourceID);
    //
    //     sources.add(source);
    //
    //     //Save source settings
    //     await prefs.setString(
    //         source.sourceID+ _sourceNameKey, source.sourceName);
    //
    //     await prefs.setString(
    //         source.sourceID+ _sourceMediaGroupKey, source.mediaGroup.name);
    //
    //     await prefs.setString(
    //         source.sourceID+ _sourcePrimaryLabelKey, source.primaryLabel.name);
    //
    //     await prefs.setString(source.sourceID+ _sourceSecondaryLabelKey,
    //         source.secondaryLabel.name);
    //
    //     await prefs.setStringList(source.sourceID+ _sourceDirectoryKey,
    //         source.sourceDirectorys);
    //
    //     //Save updated source keys
    //     prefs.setStringList(_sourceIDKey, _sourcesIDs);
    //
    //
    //   }

    notifyListeners();
  }

  Future<void> saveData() async {
    _sourcesIDs = [];

    //Inital  tagged to be saved
    for (var source in sources) {
      saveSource(source);
    }

    await prefs.setStringList(_sourceIDKey, _sourcesIDs);
    notifyListeners();

    print("Saved all sources");
  }
}
