import 'dart:io';
import 'dart:js';

import 'package:amplify/models/database/source_db_model.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/Source_model.dart';

import 'package:amplify/models/database/media_db_model.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'amplifying_color_provider.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();

  //DB
  SourceDBModel sourceDBModel_ = SourceDBModel();
  MediaDBModel mediaDBModel_ = MediaDBModel();

  AudioPlayer player_ = AudioPlayer();

  Metadata? currentSongMetadata;
  Directory? currentSongPath;

  Map<String, int> loadingValue = {};

  Future<void> loadData(BuildContext context)

  async {

    loadingValue = {};
    await sourceDBModel_.refreshSourceData();
  }

  Future<void> deleteSource(String sourceID) async {
    sourceDBModel_.deleteSource(sourceID);

    notifyListeners();
  }

  Future<void> saveSource(MediaSource source) async {
    sourceDBModel_.addSourceToDB(source);
    notifyListeners();
  }

  void addMedia(){
    notifyListeners();
  }

  Future<void> playMusic(Directory mediaPath, BuildContext? context, )
  async {
        currentSongPath = mediaPath;
        currentSongMetadata = await MetadataGod.readMetadata(file: mediaPath.path);

        if(context != null)
        {
          PaletteGenerator.fromImageProvider(Image.memory(currentSongMetadata!.picture!.data).image).then((value){
            context.read<ColorProvider>().updateWithPaletteGenerator(value);
          });
        }

        print(mediaPath);

        //DeviceFileSource(path.path);
        player_.play(DeviceFileSource(currentSongPath!.path));
        
        notifyListeners();
      }

}
