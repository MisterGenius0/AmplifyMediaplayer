import 'dart:io';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/services/database/media_db.dart';
import 'package:flutter/cupertino.dart';
import 'package:amplify/models/source_model.dart';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';


import 'package:metadata_god/metadata_god.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import 'package:amplify/services/database/source_db.dart';
import 'package:windows_taskbar/windows_taskbar.dart';
import 'package:amplify/models/media_Model.dart';
import 'amplifying_color_provider.dart';

class MediaProvider extends ChangeNotifier {

  MediaProvider();

  //DB
  final SourceDBModel _sourceDBModel = SourceDBModel();

  AudioPlayer player = AudioPlayer();

  Metadata? currentSongMetadata;
  Picture? currentSongPicture;
  Directory? currentSongPath;
  List<String> mediaPlaylist = [];
  int playlistIndex = 0;

  bool useNewSystem = false;

  Directory? _currentMetadataPath;


  HardwareKeyboard keyboard = HardwareKeyboard();

  //TODO record current source and group used for bread crum and playing all songs in source
  MediaSource? currentSource;
  MediaGroup? currentGroup;

  Map<String, int> loadingValue = {};

  //Data functions


  Future<void> loadData(BuildContext context) async {
    player.playbackEventStream.listen((event) {playbackEvent(event);});
    player.positionStream.listen((event) {playingTick();});

    loadingValue = {};

    if(!kIsWeb)
      {
        await _sourceDBModel.refreshSourceData(context);
      }
    else
      {
        //await _sourceService.RefreshSourceData();
      }
  }

  //TODO add hardwere keybord back lol
  //HardwareKeyboard.instance.KeyDownEvent

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

  Future<void> playMedia({Directory? mediaPath, BuildContext? context, bool clearPlaylist = false, bool shuffle = false })
  async {
    player.pause();
    MediaDBModel dbModel = MediaDBModel();
    if(useNewSystem)
      {
        await player.pause();
        if(currentSource != null)
        {
          if(currentGroup != null)
          {
            await player.setLoopMode(LoopMode.all);
            MediaDBModel dbModel = MediaDBModel();
            await dbModel.getMediaFromGroup(currentGroup!);
            List<Media> allMedia =  await dbModel.getMediaFromGroup(currentGroup!);
            List<String> stringMedia = allMedia.map((e) {return e.mediaPath.path;}).toList();

             int mediaIndex = stringMedia.indexOf(mediaPath!.path);
            ConcatenatingAudioSource source = ConcatenatingAudioSource(children: allMedia.map((media) => AudioSource.file(media.mediaPath.path, tag: media.mediaPath.path)).toList());
            await player.setAudioSource(source, initialIndex: mediaIndex);
            await player.play();
          }
          else
          {
            await player.setAudioSource(AudioSource.file(mediaPath!.path, tag: mediaPath.path));
          }
        }
        else
        {
          await player.setAudioSource(AudioSource.file(mediaPath!.path, tag: mediaPath.path));
        }
      }
    else
    {
      if(clearPlaylist == true)
      {
        mediaPlaylist = [];
      }

      //Find songs in group
      if(currentGroup != null)
      {
        //play in a group
        if(clearPlaylist)
          {
            dbModel.getMediaFromGroup(currentGroup!);
            List<Media> allMedia =  await dbModel.getMediaFromGroup(currentGroup!);
            List<String> mediaInGroup = [];
            mediaPlaylist = mediaInGroup;
            for(Media media in  allMedia)
            {
              mediaInGroup.add(media.mediaPath.path);
            }

            playlistIndex = mediaPath != null ? mediaPlaylist.indexOf(mediaPath.path) : 0;
          }

       // print(mediaPlaylist);
        await player.setAudioSource(AudioSource.file(mediaPlaylist[playlistIndex], tag: mediaPlaylist[playlistIndex]));
      }
      else if (currentSource != null)
        {
          //play in a source
          if(clearPlaylist)
          {
            List<Media> allMedia =  await dbModel.getAllMediaFromSource(currentSource!);
            List<String> mediaInGroup = [];
            mediaPlaylist = mediaInGroup;
            for(Media media in  allMedia)
            {
              mediaInGroup.add(media.mediaPath.path);
            }

            playlistIndex = mediaPath != null ? mediaPlaylist.indexOf(mediaPath.path) : 0;
          }

          // print(mediaPlaylist);
          await player.setAudioSource(AudioSource.file(mediaPlaylist[playlistIndex], tag: mediaPlaylist[playlistIndex]));
        }
      else{
        if(mediaPath?.path != null)
          {
            await player.setAudioSource(AudioSource.file(mediaPath!.path, tag: mediaPath.path));
          }
        else
          {
            if (kDebugMode) {
              print("Evrything is null Cant play music!");
            }
          }
      }


      if(shuffle)
        {
          await shufflePlayList();
        }

      await player.play();

      currentSongPath = Directory(player.sequence?[player.currentIndex!].tag);

      player.audioSource.toString();
    }

    notifyListeners();
  }

  Future<void> playbackEvent(PlaybackEvent event)
  async {
    //print(event);

    // if(player.sequence != null && event.currentIndex != null)
    //   {
    //
    //     print(currentSongPath);
    //   }


    // if(event.processingState == ProcessingState.loading)
    //   {
    //     WindowsTaskbar.setProgressMode(TaskbarProgressMode.indeterminate);
    //   }
    // else
    //   {
    //     WindowsTaskbar.setProgressMode(TaskbarProgressMode.normal);
    //   }

    // if(event.processingState == ProcessingState.completed)
    // {
    //   print("DoNE");
    //   playlistIndex++;
    //
    //   if(playlistIndex >= mediaPlaylist.length)
    //   {
    //     playlistIndex = 0;
    //   }
    //
    //   await playMedia(mediaPath: Directory(mediaPlaylist[playlistIndex]));
    // }
    //
    // print(event);
    // print("now Playing: ${player.sequence?[event.currentIndex!].tag}");
  }

  //media controls
  Future<void> toggleMediaPlayState () async {
    if (player.playing) {
      await player.pause();
    }
    else {
      await player.play();
    }
  }

  //Restarts the media back to the beginning
  Future<void> restartMedia({bool autoPlay = false})
  async {

    {
      await player.setAudioSource(AudioSource.file(currentSongPath!.path), initialPosition: const Duration());

      if(useNewSystem)
        {
          player.seek(const Duration());
        }

      if(autoPlay)
      {
        await player.play();
      }
    }
    notifyListeners();
  }

  Future<void> playNext()
  async {
    if(useNewSystem)
      {
        if(player.hasNext)
        {
          await player.seekToNext();
        }
      }
    else
      {
        playlistIndex++;

        if(playlistIndex >= mediaPlaylist.length)
        {
          playlistIndex = 0;
        }

        await playMedia(mediaPath: Directory(mediaPlaylist[playlistIndex]));
      }
  }

  Future<void> playPrevious()
  async {
    if(useNewSystem)
      {
        if(player.hasPrevious)
        {
          await player.seekToPrevious();
        }
      }
    else
      {
        playlistIndex--;

        if(playlistIndex <=0)
        {
          playlistIndex = mediaPlaylist.length -1;
        }

        await playMedia(mediaPath: Directory(mediaPlaylist[playlistIndex]));
      }

  }

  Future<void> updateColor({required BuildContext context})
  async {
    if (currentSongPath != null) {
      if(_currentMetadataPath?.path != currentSongPath?.path) {
        _currentMetadataPath = currentSongPath;

        if (kDebugMode) {
          print("Update color");
        }
        currentSongMetadata =
        await MetadataGod.readMetadata(file: currentSongPath!.path);
        PaletteGenerator.fromImageProvider(Image
            .memory(currentSongMetadata!.picture!.data)
            .image).then((value) {
          context.read<ColorProvider>().updateWithPaletteGenerator(value);
        });
      }
    }
  }

  void playingTick()
  {
    updateWindowsStatus();
    notifyListeners();

    if(player.processingState == ProcessingState.completed)
      {
        playNext();
      }
    if(player.processingState == ProcessingState.loading)
      {
        WindowsTaskbar.setProgressMode(TaskbarProgressMode.indeterminate);
      }
  }

  Future<void> onFinishedMedia()
  async {
    if(useNewSystem)
    {
      player.seekToNext();
    }


    if(mediaPlaylist.length > 2)
      {
       await playNext();
      }
    else
      {
        await player.setAudioSource(AudioSource.file(currentSongPath!.path), initialPosition: const Duration());
      }
  }

Future<void> shufflePlayList()
async {
    if(useNewSystem)
      {
        await player.shuffle();
        await player.seekToNext();
      }
    else
      {
        if (kDebugMode) {
          print("Shuffle");
        }
        mediaPlaylist.shuffle();
        playlistIndex = 0;
        await playMedia(mediaPath: Directory(mediaPlaylist[0]));
      }
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

  void updatePath({required BuildContext context, MediaSource? mediaSource, MediaGroup? mediaGroup})
  {
        currentSource = mediaSource;
        currentGroup = mediaGroup;

        if (kDebugMode) {
          print("Source: ${currentSource?.sourceName}");
          print("Group: ${currentGroup?.name}");
        }

        notifyListeners();
  }

  void updateState()
  {
    print("UPDATE");
    notifyListeners();
  }
}



