import 'dart:io';

import 'package:amplify/models/media_group_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

class MediaSubpageController
{
  void mediaOnPress({required Directory clickedMedia, required BuildContext context, MediaGroup? mediaGroup})
  {
    //SourceSettingsBuilder(context);
    context.read<MediaProvider>().playMedia(mediaPath: clickedMedia, context: context, clearPlaylist: true);
  }
}
