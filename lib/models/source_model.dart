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
    required this.sourceFiles,
    required this.excludedFiles,
    required this.excludedDirectorys,
  });

  final String sourceName;

  late String sourceID = "";

  final MediaGroups mediaGroup;

  final MediaGroupLabels primaryLabel;

  final MediaGroupLabels secondaryLabel;

  final List<String> sourceDirectorys;
  final List<String> sourceFiles;

  final List<String> excludedFiles;
  final List<String> excludedDirectorys;


  //TODO move this to a controller not in a model
  ValueNotifier<int>countNotifier = ValueNotifier<int>(-1);

  int fileCount = 0;
  int currentCount = 0;

  //List of sources

  //Map of sorted music

  void generateID() {
    sourceID = "${sourceName}_${DateTime.timestamp()}".replaceAll("'", "");
  }

  // Future<int>  getFileCount() async
  // {
  //   FileController fileController = FileController();
  //   for (var source in sourceDirectorys) {
  //     await fileController.findAudioFilesInDirectory(url: source,
  //         onFinished: (files)  {
  //           for (var file in files) {
  //             fileCount++;
  //           }
  //         },
  //         onError: (e) {
  //         });
  //   }
  //
  //   return fileCount;
  // }

  Stream<double> refreshMedia() async* {
    FileController fileController = FileController();
    MediaDBModel mediaDBModel = MediaDBModel();
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

    fileCount = 0;
    //All file count
        // countNotifier.value = currentCount;
        //context.watch<MediaProvider>().addMedia();
        // print(countNotifier.hasListeners);
        // print("${currentCount} / ${totalcount}");
        // print("${currentCount / totalcount * 100} %");


    mediaDBModel.deleteMediaTable(sourceID);
    //TODO look into streams lol

   //source files list and bool for do once
    List<Directory> addedSourceFiles = [];
    bool hasSourceFiles = false;

    //Convert added files to Directorys
    for(var item in sourceFiles)
      {
        if(item != "")
          {
            addedSourceFiles.add(Directory(item));
          }
      }


    for (var source in sourceDirectorys) {
      List<Directory> files = await fileController.findAudioFilesInDirectory(url: source);

      //Do once, add source files for first Directory only
      if(hasSourceFiles != true)
        {
          files.addAll(addedSourceFiles);
          hasSourceFiles = true;
        }

      fileCount = files.length;

      currentCount = 0;
      for(var file in files)
        {
          //Exclude files in the exclude file array
          bool excludeFile = excludedFiles.any((sub){

            if(sub != "")
            {
              return file.path.toString() == sub;
            }
            return false;
          });

          //Exclude directory, see if the incoming file is part of a excluded directory
          bool excludeDirectory = excludedDirectorys.any((sub){

           if(sub != "")
             {
               return file.toString().contains(sub);
             }
            return false;
          });

          if(excludeDirectory != true && excludeFile != true)
            {
              await addMediaToTable(Directory(file.path), sourceID);
            }
          else
            {
              print("Excluded: ${file.toString()}");
            }

          currentCount++;
          // print("Add Fikle $file, $sourceID");
          yield currentCount/fileCount;
          //print("$currentCount / ${fileCount} ${currentCount/fileCount *100}% done");
          // countNotifier.value = currentCount;
          //context.watch<MediaProvider>().addMedia();
          // print(countNotifier.hasListeners);
          // print("${currentCount} / ${totalcount}");
          // print("${currentCount / totalcount * 100} %");
        }
      //yield streamController.stream;
  }}

  Future<void> addMediaToTable(Directory mediaPath, String iD) async {
    Metadata metadata = await MetadataGod.readMetadata(file: mediaPath.path);
    MediaDBModel mediaDBModel = MediaDBModel();
    // print(mediaPath.path);

    await mediaDBModel.addMediaToTable(iD, metadata, mediaPath);
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
