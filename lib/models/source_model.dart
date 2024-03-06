import 'dart:async';
import 'dart:io';

import 'package:amplify/controllers/file_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:metadata_god/metadata_god.dart';

//TODO remove refrance to media_db
import 'package:amplify/services/database/media_db.dart';

class MediaSource {
  MediaSource({
    required this.sourceName,
    required this.mediaGroup,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.sourceDirectorys,
  });

  final String sourceName;

  late String sourceID = "";

  final MediaGroups mediaGroup;

  final MediaGroupLabels primaryLabel;

  final MediaGroupLabels secondaryLabel;

  final List<String> sourceDirectorys;




  //TODO move this to a controller not in a model
  ValueNotifier<int>countNotifier = ValueNotifier<int>(-1);

  int fileCount = 0;
  int currentCount = 0;

  //List of sources

  //Map of sorted music

  void generateID() {
    sourceID = "${sourceName}_${DateTime.timestamp()}".replaceAll("'", "");
  }

  Future<int>  getFileCount() async
  {
    FileController fileController = FileController();
    for (var source in sourceDirectorys) {
      await fileController.findAudioFilesInDirectory(url: source,
          onFinished: (files)  {
            for (var file in files) {
              fileCount++;
            }
          },
          onError: (e) {
          });
    }

    return fileCount;
  }

  void refreshMedia() async {
    FileController fileController = FileController();
    MediaDBModel mediaDBModel = MediaDBModel();

    fileCount = 0;
    currentCount = 0;
    // for (var source in sourceDirectorys) {
    //   fileController.findAudioFilesInDirectory(url: source,
    //       onFinished: (files) async {
    //         for (var file in files) {
    //           totalcount++;
    //         }
    //       },
    //       onError: (e) {
    //       });
    // }

    mediaDBModel.deleteMediaTable(sourceID);
    //TODO look into streams lol
    for (var source in sourceDirectorys) {
      fileController.findAudioFilesInDirectory(url: source,
          onFinished: (files) async {
          for (var file in files) {
              await addMediaToTable(file, sourceID);
              fileCount++;
              // countNotifier.value = currentCount;
              //context.watch<MediaProvider>().addMedia();
              // print(countNotifier.hasListeners);
              // print("${currentCount} / ${totalcount}");
              // print("${currentCount / totalcount * 100} %");
            }
          },
          onError: (e) {
          });
    }
  }

  Future<void> addMediaToTable(Directory mediaPath, String iD) async {
    Metadata metadata = await MetadataGod.readMetadata(file: mediaPath.path);
    MediaDBModel mediaDBModel = MediaDBModel();
    // print(mediaPath.path);

    mediaDBModel.addMediaToTable(iD, metadata, mediaPath);
  }
}



enum MediaGroups { album, artist, year, genre, albumArtist }

enum MediaGroupLabels {
  artistCount,
  albumCount,
  totalTime,
  songCount,
  yearRange,
  genreCount,
  albumArtestCount,
  composerCount,
  discNumbers,
}
