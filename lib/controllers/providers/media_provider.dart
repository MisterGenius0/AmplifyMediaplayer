import 'dart:io';

import 'package:amplify/models/database/source_db_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/Source_model.dart';

import 'package:amplify/models/database/media_db_model.dart';
import 'package:just_audio/just_audio.dart';


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

  Future<void> loadData(BuildContext context) async {

    //We need this play because the first time player plays something it dose not work
    player_.play();

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

  Future<void> StopMusic()
  async {

    await player_.stop();

    currentSongPath = null;
    currentSongMetadata = null;

    notifyListeners();
  }


  Future<void> playMusic(Directory mediaPath, BuildContext? context, )
  async {
    if (player_.playing) {
      await player_.stop();
    }

    await player_.setAudioSource(AudioSource.file(mediaPath.path)).then((
        value) => {player_.play()});


    currentSongPath = mediaPath;
    currentSongMetadata = await MetadataGod.readMetadata(file: mediaPath.path);

    if (context != null) {
      PaletteGenerator.fromImageProvider(Image
          .memory(currentSongMetadata!.picture!.data)
          .image).then((value) {
        context.read<ColorProvider>().updateWithPaletteGenerator(value);
      });
    }

    notifyListeners();
  }
}

