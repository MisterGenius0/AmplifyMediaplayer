import 'dart:io';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/services/database/media_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/Source_model.dart';

import 'package:flutter/foundation.dart';
import 'package:just_audio/just_audio.dart';


import 'package:metadata_god/metadata_god.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'package:amplify/services/database/source_db.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import '../../models/media_Model.dart';
import 'amplifying_color_provider.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();

  //DB
  final SourceDBModel _sourceDBModel = SourceDBModel();

  AudioPlayer player = AudioPlayer();

  Metadata? currentSongMetadata;
  Directory? currentSongPath;
  List<Directory> mediaPlaylist = [];
  int playlistIndex = 0;

  Map<String, int> loadingValue = {};

  //Data functions

  Future<void> loadData(BuildContext context) async {

    //We need this play because the first time player plays something it dose not work
    player.play();

    loadingValue = {};

    if(!kIsWeb)
      {
        await _sourceDBModel.refreshSourceData();
      }
    else
      {
        //await _sourceService.RefreshSourceData();
      }
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

  Future<void> stopMusic()
  async {

    await player.stop();

    WindowsTaskbar.setProgressMode(TaskbarProgressMode.noProgress);
    currentSongPath = null;
    currentSongMetadata = null;

    notifyListeners();
  }

  //Media functions

  Future<void> playMedia({required Directory mediaPath, BuildContext? context, MediaGroup? group, bool clearPlaylist = false })
  async {
    MediaDBModel dbModel = MediaDBModel();
    WindowsTaskbar.setProgressMode(TaskbarProgressMode.indeterminate);

    currentSongPath = mediaPath;

    if (player.playing) {
      await player.stop();
    }

    if(clearPlaylist == true)
      {
        mediaPlaylist = [];
      }

    //Find songs in group
    if(group != null)
      {
        dbModel.getMediaFromGroup(group);

        List<Media> allMedia =  await dbModel.getMediaFromGroup(group);
        List<Directory> mediaInGroup = [];


        //TODO START HERE NEXT TIME AND FIGURE OUT WHY ITS EMPY AND -1 index
        for(Media media in  allMedia)
          {
            mediaInGroup.add(media.mediaPath);
          }
        playlistIndex = mediaPlaylist.indexOf(mediaPath);

        print(mediaPlaylist);

        print(playlistIndex);

        mediaPlaylist = mediaInGroup;
      }

    await player.setAudioSource(AudioSource.file(mediaPath.path));
    await player.play();

    player.positionStream.listen((event) {playingTick();
    });

    player.audioSource.toString();

    playlistIndex =  mediaPlaylist.indexOf(mediaPath);
    notifyListeners();
  }

  //media controls
  Future<void> toggleMediaPlayState()
  async {
    if (player.playing) {
      await player.pause();
    }
    else {
      await player.play();
    }

    notifyListeners();
  }

  //Restarts the media back to the beginning
  Future<void> restartMedia({bool autoPlay = false})
  async {

    {
      await player.setAudioSource(AudioSource.file(currentSongPath!.path), initialPosition: const Duration());
      if(autoPlay)
      {
        await player.play();
      }
    }
    notifyListeners();
  }

  void playNext()
  {
    print("${playlistIndex} forward");
    playlistIndex++;

    print("$mediaPlaylist");

    if(playlistIndex >= mediaPlaylist.length)
    {
      print("Test");
      playlistIndex = 0;
    }

    print("${playlistIndex} forward");
    playMedia(mediaPath: mediaPlaylist[playlistIndex]);
  }

  void playPrevious()
  {
    print("${playlistIndex} rewind");
    playlistIndex--;

    print("$mediaPlaylist");

    if(playlistIndex <=0)
      {
        playlistIndex = mediaPlaylist.length -1;
      }

    print("${playlistIndex} rewind");
    playMedia(mediaPath: mediaPlaylist[playlistIndex]);
  }

  Future<void> updateColor({required BuildContext context})
  async {
    currentSongMetadata = await MetadataGod.readMetadata(file: currentSongPath!.path);
    PaletteGenerator.fromImageProvider(Image
        .memory(currentSongMetadata!.picture!.data)
        .image).then((value) {
      context.read<ColorProvider>().updateWithPaletteGenerator(value);
    });
  }

  void playingTick()
  {
    if(player.position.inMilliseconds == player.duration?.inMilliseconds)
      {
        onFinishedMedia();
      }

    updateWindowsStatus();
    notifyListeners();
  }

  Future<void> onFinishedMedia()
  async {
    player.seekToNext();

    if(player.hasNext)
      {
        player.seekToNext();
      }
    else
      {
        await player.setAudioSource(AudioSource.file(currentSongPath!.path), initialPosition: const Duration());
      }
    notifyListeners();

    //player.seekToPrevious();
  }




  //Other functions
  void updateWindowsStatus()
  {
    if(player.playing)
      {
        WindowsTaskbar.setProgressMode(TaskbarProgressMode.normal);
        WindowsTaskbar.setProgress(player.position.inSeconds, player.duration?.inSeconds ?? 0  );
      }
    else if(player.duration !=null)
      {
        WindowsTaskbar.setProgressMode(TaskbarProgressMode.paused);
      }
  }
}



