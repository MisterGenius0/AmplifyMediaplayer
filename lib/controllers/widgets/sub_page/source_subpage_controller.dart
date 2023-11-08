import 'package:amplify/models/media_Group_model.dart';
import 'package:flutter/cupertino.dart';

import 'package:amplify/models/Source_model.dart';

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
}
