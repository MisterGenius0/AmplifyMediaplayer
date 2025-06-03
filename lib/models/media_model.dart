import 'dart:io';

import 'package:amplify/models/media_group_model.dart';
import 'package:metadata_god/metadata_god.dart';

class Media {

  Media({
    required this.mediaPath,
    required this.iD,
    required this.mediaName,
    required this.secondaryLabel,
    required this.trackNumber,
    required this.discNumber,
    required this.album,
    required this.group,
  });

  final Directory mediaPath;
  final String iD;

  // //metadata
   final String? mediaName;
   final String ? secondaryLabel;  //Hard coded duration for now  //Duration - Composer - Album - Artist - Album Artist -  Year - Genre
   final int? trackNumber;
   final int? discNumber;
   final String? album;

  final MediaGroup? group;

  Future<Metadata> readMetadata() async
  {
    Metadata metadata = await MetadataGod.readMetadata(file: mediaPath.path);
    return metadata;
  }
}

