import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';

import 'package:amplify/models/source_model.dart';

class SourceSettingsController
{
  FileController fileController = FileController();

  void onReloadSource(MediaSource mediaSource, BuildContext context)
  {
    //TODO add this to loading map and have a progress bar appear when its in the list
    mediaSource.refreshMedia().listen((event) {print("${mediaSource.sourceName} ...loading:  ${event*100}%");});
  }

  void onDeleteSource(MediaSource mediaSource, BuildContext context)
  {
    context.read<MediaProvider>().deleteSource(mediaSource.sourceID);
    Navigator.pop(context);
  }

  void onSaveSource({
    required BuildContext context,
    MediaSource? existingSource,
    required String name,
    required MediaGroups mediaGroups,
    required MediaGroupLabels primaryLabel,
    required MediaGroupLabels secondaryLabel,
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
      if (kDebugMode) {
        print("NO Exsisting source!");
      }
      source.generateID();
    }
    else
    {
      if (kDebugMode) {
        print("Existing source!");
      }
      context.read<MediaProvider>().deleteSource(existingSource.sourceID);
      source.sourceID = existingSource.sourceID;
    }

    //adds source to DB
    context.read<MediaProvider>().saveSource(source);
    onReloadSource(source, context);
    Navigator.pop(context);
  }
}



