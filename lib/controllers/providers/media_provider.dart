import 'package:amplify/models/database/source_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/Source_model.dart';

import 'package:amplify/models/database/media_db_model.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();

  //DB
  SourceDBModel sourceDBModel = SourceDBModel();
  MediaDBModel mediaDBModel = MediaDBModel();

  Map<String, int> loadingValue = {};

  Future<void> loadData(BuildContext context) async {

    loadingValue = {};
    await sourceDBModel.refreshSourceData();
  }

  Future<void> deleteSource(String sourceID) async {
    sourceDBModel.deleteSource(sourceID);

    notifyListeners();
  }

  Future<void> saveSource(MediaSource source) async {
    sourceDBModel.addSourceToDB(source);
    notifyListeners();
  }

  void addMedia(){
    notifyListeners();
  }


}
