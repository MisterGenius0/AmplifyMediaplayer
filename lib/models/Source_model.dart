import 'dart:io';

import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:provider/provider.dart';

class MediaSource {
  MediaSource({
    required this.sourceName,
    required this.mediaGroup,
    required this.primaryLabel,
    required this.secondaryLabel,
    required this.sourceDirectorys,
  });

  final String sourceName;

  final MediaGroups mediaGroup;

  final MediaLabels primaryLabel;

  final MediaLabels secondaryLabel;

  final List<String> sourceDirectorys;

  late String sourceID = "";

  late List<Media> mediaList = [];

  //TODO move this to a controller not in a model
  ValueNotifier<int>countNotifier = ValueNotifier<int>(-1);

  int totalcount = 0;
  int currentCount = 0;

  //List of sources

  //Map of sorted music

  void generateID() {
    sourceID = "${sourceName}_${DateTime.timestamp()}".replaceAll("'", "");
  }

  void refreshMedia() async {
    FileController fileController = FileController();

    totalcount = 0;
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

    for (var source in sourceDirectorys) {
      fileController.findAudioFilesInDirectory(url: source,
          onFinished: (files) async {
            for (var file in files) {
              Media media = Media(mediaPath: file, iD: sourceID);
              await MetadataGod.readMetadata(file: file.path);
              await media.saveMetadata();
              // currentCount++;
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
}

enum MediaGroups { album, artist, year, genre, albumArtest }

enum MediaLabels {
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
