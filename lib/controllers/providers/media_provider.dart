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
  final SourceDBModel _sourceDBModel = SourceDBModel();

  AudioPlayer player = AudioPlayer();

  Metadata? currentSongMetadata;
  Directory? currentSongPath;

  Map<String, int> loadingValue = {};

  Future<void> loadData(BuildContext context) async {

    //We need this play because the first time player plays something it dose not work
    player.play();

    loadingValue = {};
    await _sourceDBModel.refreshSourceData();
  }

  Future<void> deleteSource(String sourceID) async {
    _sourceDBModel.deleteSource(sourceID);

    notifyListeners();
  }

  Future<void> saveSource(MediaSource source) async {
    _sourceDBModel.addSourceToDB(source);
    notifyListeners();
  }

  void addMedia(){
    notifyListeners();
  }

  Future<void> StopMusic()
  async {

    await player.stop();

    currentSongPath = null;
    currentSongMetadata = null;

    notifyListeners();
  }


  Future<void> playMusic(Directory mediaPath, BuildContext? context, )
  async {
    if (player.playing) {
      await player.stop();
    }

    await player.setAudioSource(AudioSource.file(mediaPath.path)).then((
        value) => {
      player.play(),
    player.positionStream.listen((event) {playingTick(); })
    });







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

  void playingTick()
  {
    notifyListeners();
  }
}



