import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../providers/media_provider.dart';

class QuickactionControlsController
{
  void shuffleOnPress(BuildContext context)
  {

    //TODO continue here
    if(context.read<MediaProvider>().currentGroup?.name != null)
      {
        context.read<MediaProvider>().shufflePlayList();
      }
    else if(context.read<MediaProvider>().currentSource?.sourceName != null)
      {

      }

  }
}
