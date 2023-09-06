import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:metadata_god/metadata_god.dart';


class Media
{

   Media({
    required this.mediaPath,
     required this.iD,
  });

  final Directory mediaPath;
   final String? iD;
   late Metadata metadata;

  Future<void> saveMetadata(BuildContext context)
  async {
    // MetadataGod.initialize();
    // metadata = await MetadataGod.readMetadata(file: mediaPath.path);
    //
    // Database db = context.read<DBProvider>().getMediaDB();
    //
    // //DB test
    // final stmt = db.prepare('''INSERT INTO ${iD}_media (title,
    //     durationMs,
    //     artist, album,
    //     albumArtist,
    //     trackNumber,
    //     trackTotal,
    //     discNumber,
    //     discTotal,
    //     year,
    //     genre,
    //     picture,
    //     fileSize
    //     ) VALUES (?,?,?,?,?,?,?,?,?,?,?,?,?)''');
    // stmt
    //   .execute([
    //     metadata.title,
    //     metadata.durationMs,
    //     metadata.artist,
    //     metadata.album,
    //     metadata.albumArtist,
    //     metadata.trackNumber,
    //     metadata.trackTotal,
    //     metadata.discNumber,
    //     metadata.discTotal,
    //     metadata.year,
    //     metadata.genre,
    //     metadata.picture?.data,
    //     metadata.fileSize
    //   ]);
    // print("Saved: ${metadata.title}");
  }
}