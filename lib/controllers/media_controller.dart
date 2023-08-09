import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Source_model.dart';

class MediaProvider extends ChangeNotifier {
  late final SharedPreferences prefs;

  List<MediaSource> sources = [];

  List<String> _sourcesIDs = [];

  //KEYS
  String _sourceIDKey = "SourceID";

  String _sourceNameKey = "_Name";

  String _sourceMediaGroupKey = "_Group";

  String _sourcePrimaryLabelKey = "_PrimaryLabel";

  String _sourceSecondaryLabelKey = "_SecondaryLabel";

  void LoadSources() {}

  Future<void> LoadData() async {
    prefs = await SharedPreferences.getInstance();
    List<String>? SourceIDs = prefs.getStringList(_sourceIDKey);

    if (SourceIDs != null) {
      for (var sourceID in SourceIDs) {
        String? SourceName =
            prefs.getString(sourceID + _sourceNameKey) ?? "NULL";

        String? mediaGroup =
            prefs.getString(sourceID + _sourceMediaGroupKey) ?? "NULL";

        String? primaryLabel =
            prefs.getString(sourceID + _sourcePrimaryLabelKey) ?? "NULL";

        String? secondaryLabel =
            prefs.getString(sourceID + _sourceSecondaryLabelKey) ?? "NULL";

        _sourcesIDs.add(sourceID);

        MediaSource CreatedSource = MediaSource(
            sourceName: SourceName,
            mediaGroup: MediaGroups.values.byName(mediaGroup),
            primaryLabel: MediaLabels.values.byName(primaryLabel),
            secondaryLabel: MediaLabels.values.byName(secondaryLabel));
        CreatedSource.sourceID = sourceID;

        sources.add(CreatedSource);
        print("Loaded: " + sourceID);
      }
    }

    print("Finished loading");
    notifyListeners();
  }

  Future<void> DeleteSource(String sourceID) async {
    await prefs.remove(sourceID);
  }

  Future<void> SaveSources() async {
    _sourcesIDs = [];

    //Inital  tagged to be saved
    for (var source in sources) {
      _sourcesIDs.add(source.sourceID);

      await prefs.setString(
          source.sourceID + _sourceNameKey, source.sourceName);
      await prefs.setString(
          source.sourceID + _sourceMediaGroupKey, source.mediaGroup.name);
      await prefs.setString(
          source.sourceID + _sourcePrimaryLabelKey, source.primaryLabel.name);
      await prefs.setString(source.sourceID + _sourceSecondaryLabelKey,
          source.secondaryLabel.name);
    }

    await prefs.setStringList(_sourceIDKey, _sourcesIDs);
    notifyListeners();

    print("Saved all sources");
  }
}
