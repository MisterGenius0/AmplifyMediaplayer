import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:amplify/models/Source_model.dart';

class GroupSubpageController
{
  void groupOnPress(BuildContext context, [MediaGroup? mediaGroups])
  {
    print(mediaGroups?.name);
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/media", arguments: {"mediaGroups" : mediaGroups});
  }

  void groupSettingsOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    // MediaSource? media = mediaSource;
    // //SourceSettingsBuilder(context);
    // Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : media});
  }
}
