import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

class QuickActionControlsController
{
  void shuffleOnPress(BuildContext context)
  {
    if(context.read<MediaProvider>().currentGroup?.name != null)
      {
        context.read<MediaProvider>().playMedia(shuffle: true, clearPlaylist: true);
      }
    context.read<MediaProvider>().playMedia(shuffle: true, clearPlaylist: true);
  }

  void playOnPress(BuildContext context)
  {
    if(context.read<MediaProvider>().currentGroup?.name != null)
    {
      context.read<MediaProvider>().playMedia(shuffle: false, clearPlaylist: true);
    }
    context.read<MediaProvider>().playMedia(shuffle: false, clearPlaylist: true);
  }
}
