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
    mediaSource.refreshMedia(context);
  }

  void onDeleteSource(MediaSource mediaSource, BuildContext context)
  {
    print(mediaSource);
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
      source.generateID();
    }
    else
    {
      context.read<MediaProvider>().sources.remove(existingSource);
      source.sourceID = existingSource.sourceID;
    }

    //source.generateGroups();
    //source.refreshMedia(context);
    context.read<MediaProvider>().saveSource(source);
    Navigator.pop(context);

  }
}



