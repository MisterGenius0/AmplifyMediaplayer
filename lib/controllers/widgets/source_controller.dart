import 'package:flutter/cupertino.dart';

import 'package:amplify/models/Source_model.dart';

class SourceController
{
  void sourceOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    MediaSource? media = mediaSource;
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/groups", arguments: {"mediaSource" : media});
  }

  void sourceSettingsOnPress(BuildContext context, [MediaSource? mediaSource])
  {
    MediaSource? media = mediaSource;
    //SourceSettingsBuilder(context);
    Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : media});
  }
}

