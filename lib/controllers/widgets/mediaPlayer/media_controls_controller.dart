import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

class MediaControlsController
{

  void pressPausePlay(BuildContext context)
  {
    context.read<MediaProvider>().toggleMediaPlayState();
  }

  void pressStop(BuildContext context)
  {
    context.read<MediaProvider>().stopMusic();
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