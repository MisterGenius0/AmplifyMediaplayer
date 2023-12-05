import 'package:flutter/cupertino.dart';

import 'package:amplify/models/Source_model.dart';

import 'package:amplify/models/database/source_db_model.dart';

class SourceSubpageController
{
  void sourceOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/groups", arguments: {"mediaSource" : mediaSource});
  }

  void sourceSettingsOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    MediaSource? media = mediaSource;
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : media});
  }

  //SourceDB model functions
  Future<List<MediaSource>> getAllSources(BuildContext context)
  {
    late SourceDBModel sourceDBModel = SourceDBModel();
    Future<List<MediaSource>> sources  = sourceDBModel.getAllSources();
    return sources;
  }

  Future<List<ImageProvider<Object>>> getSourceImages(BuildContext context, String sourceID) async
  {
    SourceDBModel sourceDBModel = SourceDBModel();
  return  sourceDBModel.getSourceImages(sourceID);
  }

  Future<List<Future<List<ImageProvider<Object>>>>> getPictures() async
  {
    SourceDBModel sourceDBModel = SourceDBModel();
    List<Future<List<ImageProvider>>> images = [];
    List<MediaSource> sources = await sourceDBModel.getAllSources();
    for (var source in sources)
    {
      images.add(sourceDBModel.getSourceImages(source.sourceID));
    }
    return images;
  }
}
