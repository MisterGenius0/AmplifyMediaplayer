import 'dart:io';

import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/models/media_Model.dart';

import 'media_Group_model.dart';

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

  late List<MediaGroup> mediaGroupList;

  late List <Media> mediaList = [];

  late Map<String, List<Media>> groups = {};

  //List of sources

  //Map of sorted music

  void deleteSource() {}

  void generateID() {
    sourceID = "${DateTime.timestamp()}";
  }

  void refreshMedia() async {
    FileController fileController = FileController();
    List<Directory> allFiles = [];

    //Find all files in source
    for (var source in this.sourceDirectorys) {
      fileController.findAudioFilesInDirectory(
          url: source,
          onFinished: (e) {
            e.forEach((element) async {
              Media media = Media(mediaPath: element,);
              await media.loadMetadata().then((value) => mediaList.add(media));;
            });
            allFiles.addAll(e);
          });
    }
    generateGroups();
  }

  void generateGroups() async {
    switch (mediaGroup) {


      case MediaGroups.album:
        for (Media item in mediaList) {
          if (groups.containsKey(item.metadata?.album))
          {
            //Get the list
            //TODO do this here
            //Add one more media element
          }
          else
            {
              //Create the key and list
              //add media to list
            }
        }


      case MediaGroups.albumArtest:
        for (Media item in mediaList) {
          if (groups.containsKey(item.metadata?.albumArtist))
          {
            // groups.addAll({item.metadata!.albumArtist.toString() : item});
          };
        }


      case MediaGroups.artest:
        for (Media item in mediaList) {
          if (groups.containsKey(item.metadata?.artist))
          {
            // groups.addAll({item.metadata!.artist.toString() : item});
          };
        }

      case MediaGroups.genre:
        for (Media item in mediaList) {
          if (groups.containsKey(item.metadata?.genre))
          {
            // groups.addAll({item.metadata!.genre.toString() : item});
          };
        }


      case MediaGroups.year:
        for (Media item in mediaList) {
          if (groups.containsKey(item.metadata?.year))
          {
            // groups.addAll({item.metadata!.year.toString() : item});
          };
        }
      default:
        //
    }
    print(groups);

  }
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
