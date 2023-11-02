import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/models/Source_model.dart';

class SourceSettingsController
{
  FileController fileController = FileController();

  void onReloadSource(MediaSource mediaSource, BuildContext context)
  {
    mediaSource.refreshMedia();
  }

  void onDeleteSource(MediaSource mediaSource, BuildContext context)
  {
    context.read<MediaProvider>().deleteSource(mediaSource);
    Navigator.pop(context);
  }

  void onSaveSource({
    required BuildContext context,
    MediaSource? existingSource,
    required String name,
    required MediaGroups mediaGroups,
    required MediaLabels primaryLabel,
    required MediaLabels secondaryLabel,
    required List<String> sourceDirectorys,
  })
  {

//Create Source
    MediaSource source = MediaSource(
        sourceName: name,
        mediaGroup: mediaGroups,
        primaryLabel: primaryLabel,
        secondaryLabel: secondaryLabel,
        sourceDirectorys: sourceDirectorys);

    if(existingSource == null)
    {
      print("NO!!!!!!!Exsisting source!");
      source.generateID();
    }
    else
    {
      print("YES!!!!!Exsisting source!");
      context.read<MediaProvider>().deleteSource(existingSource);
      source.sourceID = existingSource.sourceID;
    }

    //adds source to DB
    context.read<MediaProvider>().saveSource(source);
    onReloadSource(source, context);
    Navigator.pop(context);
  }
}



