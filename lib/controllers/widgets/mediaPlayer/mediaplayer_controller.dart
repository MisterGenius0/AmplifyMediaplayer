import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

class MediaPlayerController
{

  void shufflePlaylist(BuildContext context)
  {
    context.read<MediaProvider>().playMedia(shuffle: true, clearPlaylist: true);
  }
}