import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:amplify/models/source_model.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

class GroupSubpageController
{
  void groupOnPress(BuildContext context, [MediaGroup? mediaGroups])
  {
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/media", arguments: {"mediaGroups" : mediaGroups});
    context.read<MediaProvider>().updatePath(context: context, mediaSource: mediaGroups?.mediaSource, mediaGroup: mediaGroups);
  }

  void groupSettingsOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    // MediaSource? media = mediaSource;
    // //SourceSettingsBuilder(context);
    // Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : media});
  }
}
