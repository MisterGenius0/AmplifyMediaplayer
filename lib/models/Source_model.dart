import 'dart:io';

import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:flutter/cupertino.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  Future<List<String>?> getGroups()
  async {
    var prefs = await SharedPreferences.getInstance();

    print("${sourceID}_groups");
   return prefs.getStringList("${sourceID}_groups");
  }

  //List of sources

  //Map of sorted music

  void deleteSource() {


  }

  Future<void> loadSourceData()
  async {
    var prefs = await SharedPreferences.getInstance();
    List<String> sources = prefs.getStringList("${sourceID}_media") ??  [];

    for(var item in sources)
      {

        Media media = Media(
            mediaPath: Directory(prefs.getString("${item}_path") ?? "NULL PATH"),
        iD: sourceID);

        // //Add to group
        // mediaList.add(media);
        // await media.loadMetadata();
        // print("Finished loading: || ${media.mediaPath}");
        // mediaList.add(media);
        // media.GetAlbum().then(
        //         (value) => _AddItemToGroup(mediaList: mediaList, key: value));
      }

}

  void generateID() {
    sourceID = "${sourceName}_${DateTime.timestamp()}";
  }

  void refreshMedia(BuildContext context) async {
    FileController fileController = FileController();

    for(var source in sourceDirectorys)
      {
        fileController.findAudioFilesInDirectory(url: source,
            onFinished: (files) async {

          for(var file in files)
            {
              Media media = Media(mediaPath: file, iD: sourceID);

             await MetadataGod.readMetadata(file: file.path);
              await media.saveMetadata();
            }
        },
        onError: (e){

        });
      }


    // //Find all files in source
    // for (var source in sourceDirectorys) {
    //   fileController.findAudioFilesInDirectory(
    //       url: source,
    //       onFinished: (e) async {
    //         for (var element in e) {
    //           Media media = Media(
    //             mediaPath: element,
    //             iD: sourceID,
    //           );
    //
    //           mediaList.add(media);
    //           await media.loadMetadata();
    //           print("Finished: ${media.mediaPath}");
    //           mediaList.add(media);
    //           media.GetAlbum().then(
    //               (value) => _AddItemToGroup(mediaList: mediaList, key: value));
    //         }
    //       });
    //   print("Finished Source: ${source}");
    // }

    //generateGroups();
  }

  void generateGroups() async {
    // groups = {};
    // switch (mediaGroup) {
    //   case MediaGroups.album:
    //     for (Media item in mediaList) {
    //       item.GetAlbum().then((value) => {
    //             if (value != null)
    //               {
    //                 item.GetAlbum().then((value) =>
    //                     _AddItemToGroup(mediaList: mediaList, key: value))
    //               }
    //             else
    //               {print("${item.mediaPath}" + " is null")}
    //           });
    //     }
    //
    //   case MediaGroups.albumArtest:
    //     for (Media item in mediaList) {
    //       // if (groups.containsKey(item.metadata?.albumArtist)) {
    //       //   // groups.addAll({item.metadata!.albumArtist.toString() : item});
    //       // }
    //       ;
    //     }
    //
    //   case MediaGroups.artest:
    //     for (Media item in mediaList) {
    //       // if (groups.containsKey(item.metadata?.artist)) {
    //       //   // groups.addAll({item.metadata!.artist.toString() : item});
    //       // }
    //       ;
    //     }
    //
    //   case MediaGroups.genre:
    //     for (Media item in mediaList) {
    //       // if (groups.containsKey(item.metadata?.genre)) {
    //       //   // groups.addAll({item.metadata!.genre.toString() : item});
    //       // }
    //       ;
    //     }
    //
    //   case MediaGroups.year:
    //     for (Media item in mediaList) {
    //       // if (groups.containsKey(item.metadata?.year)) {
    //       //   // groups.addAll({item.metadata!.year.toString() : item});
    //       // }
    //       ;
    //     }
    //   default:
    //   //
    // }
    // print(groups);
  }

  Future<void> _AddItemToGroup({required Media media, required String? iD}) async {
    //var prefs = await SharedPreferences.getInstance();

    // switch (mediaGroup) {
    //   //Album
    //   case MediaGroups.album:
    //     var album = await media.getAlbum();
    //     if(album != null)
    //       {
    //         _AddGroup(media, sourceID,  album);
    //       }
    //
    //
    //     //Artest
    //   case MediaGroups.artest:
    //     var artest = await media.getArtist();
    //     _AddGroup(media, sourceID,  artest!);
    //
    // //Year
    //   case MediaGroups.year:
    //     var year = await media.getYear();
    //     _AddGroup(media, sourceID,  year.toString());
    //
    //     //genre
    //   case MediaGroups.genre:
    //     var genre = await media.getGenre();
    //     _AddGroup(media, sourceID,  genre!);
    //
    //     //Album Artest
    //   case MediaGroups.albumArtest:
    //     var albumArtest = await media.getGenre();
    //     _AddGroup(media, sourceID, albumArtest!);
    //   default:
    // }

  }
}

Future<void> _AddGroup(Media media, String iD, String groupFilter) async {
  // var prefs = await SharedPreferences.getInstance();
  // List<String>? list = [];
  // if (prefs.getStringList("${iD}_groups") != null) {
  //
  //    list = prefs.getStringList("${iD}_groups");
  //
  //   if (!prefs.getStringList("${iD}_groups")!.contains(groupFilter)) {
  //     list?.add(groupFilter);
  //   }
  // }
  // else {
  //   List<String>? list = [];
  //     list.add(groupFilter);
  // }
  // prefs.setStringList("${iD}_groups", list!);
}

enum MediaGroups { album, artest, year, genre, albumArtest }

enum MediaLabels {
  artestCount,
  albumCount,
  totalTime,
  songCount,
  yearRange,
  genreCount,
  albumArtestCount,
  composerCount,
  discNumbers,
}
