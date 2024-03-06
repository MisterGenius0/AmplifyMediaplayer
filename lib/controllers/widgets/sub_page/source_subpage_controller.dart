import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/cupertino.dart';

import 'package:amplify/models/source_model.dart';

import 'package:amplify/services/database/source_db.dart';
import 'package:provider/provider.dart';

class SourceSubpageController
{
  void sourceOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/groups", arguments: {"mediaSource" : mediaSource});
    context.read<MediaProvider>().updatePath(context: context, mediaSource: mediaSource);
  }

  void sourceSettingsOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : mediaSource});
    context.read<MediaProvider>().updatePath(context: context, mediaSource: mediaSource);
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
