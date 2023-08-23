import 'dart:io';

import 'package:metadata_god/metadata_god.dart';

class Media
{

   Media({
    required this.mediaPath,
  });

  final Directory mediaPath;
  late Metadata? metadata = Metadata();

  Future<void> loadMetadata() async
  {
    metadata =  await MetadataGod.readMetadata(file: mediaPath.path);
    if(metadata == null)
      {

      }
    else
      {
        //Load from file
      }
  }

}