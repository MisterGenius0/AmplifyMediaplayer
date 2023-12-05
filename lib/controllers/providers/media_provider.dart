import 'package:amplify/models/database/source_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/Source_model.dart';

import 'package:amplify/models/database/media_db_model.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();

  //DB
  SourceDBModel sourceDBModel_ = SourceDBModel();
  MediaDBModel mediaDBModel_ = MediaDBModel();

  Map<String, int> loadingValue = {};

  Future<void> loadData(BuildContext context) async {

    loadingValue = {};
    await sourceDBModel_.refreshSourceData();
  }

  Future<void> deleteSource(String sourceID) async {
    sourceDBModel_.deleteSource(sourceID);

    notifyListeners();
  }

  Future<void> saveSource(MediaSource source) async {
    sourceDBModel_.addSourceToDB(source);
    notifyListeners();
  }

  void addMedia(){
    notifyListeners();
  }


}
