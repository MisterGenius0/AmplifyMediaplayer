import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/Source_model.dart';

class NewSourceController
{
  void newSourceOnPressController(BuildContext context, [MediaSource? mediaSource])
  {
    MediaSource? media = mediaSource;
    //SourceSettingsBuilder(context);
    print(media);
    Navigator.pushNamed(context, "/source settings", arguments: {"mediaSource" : media});
  }
}

