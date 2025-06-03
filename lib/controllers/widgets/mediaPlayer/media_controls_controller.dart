import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

import 'package:amplify/models/amplifying_color_models.dart';
import 'package:amplify/controllers/providers/amplifying_color_provider.dart';

class MediaControlsController
{

  void pressPausePlay(BuildContext context)
  {
    context.read<MediaProvider>().toggleMediaPlayState();
  }

  void pressStop(BuildContext context)
  {
    context.read<MediaProvider>().stopMusic();
    context.read<ColorProvider>().updateColors(defaultColor);
  }

  void pressRewind(BuildContext context)
  {
    context.read<MediaProvider>().playPrevious();
  }

  void pressFastForward(BuildContext context)
  {
    context.read<MediaProvider>().playNext();
  }

  void pressRestart(BuildContext context)
  {
    context.read<MediaProvider>().restartMedia();
  }

}
