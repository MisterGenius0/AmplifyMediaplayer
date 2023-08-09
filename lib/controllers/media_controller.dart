import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/Source_model.dart';

class MediaProvider extends ChangeNotifier
{
  late final SharedPreferences prefs;

  List<MediaSource> sources = [];

  List<String> _sourcesIDs = [];


  //Keys for saveing
  ///
  /// sources - Source IDs
  ///


  void LoadSources()
  {

  }

  Future<void> LoadData() async
  {
    prefs = await SharedPreferences.getInstance();
    prefs.getStringList("Sources")?.map((e) => {
      print(e),
    });

    notifyListeners();
  }


  Future<void> SaveSources() async
  {
    print("Test");
    print(sources);


    //Inital  tagged to be saved
    for(var source in sources)
      {
        _sourcesIDs = [];
        _sourcesIDs.add(source.sourceID);
        print("Source Saved ${source}");
        prefs.setStringList("Sources", _sourcesIDs);
      }

  }
}

