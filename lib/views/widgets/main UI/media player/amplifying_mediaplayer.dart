import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/controllers/providers/settings_provider.dart';
import 'package:amplify/controllers/widgets/mediaPlayer/mediaplayer_controller.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';
import 'package:amplify/views/widgets/main%20UI/media%20player/amplifying_media_controls.dart';
import 'package:amplify/views/widgets/main%20UI/media%20player/amplifying_media_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingMediaPlayer extends StatefulWidget {
  const AmplifyingMediaPlayer({super.key, required this.main});

  final Widget main;

  @override
  State<AmplifyingMediaPlayer> createState() => _AmplifyingMediaPlayerState();
}

class _AmplifyingMediaPlayerState extends State<AmplifyingMediaPlayer> {
  String? currentSong;
  bool isChanging = false;
  double currentSliderValue = 0;


  @override
  Widget build(BuildContext context) {
    MediaPlayerController mediaPlayerController = MediaPlayerController();
    if(!isChanging) {
      currentSliderValue = context.read<MediaProvider>().player.position.inMilliseconds.toDouble();
    }

    //Checks current song and updates color for app
      context.read<MediaProvider>().updateColor(context: context);

    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: widget.main),
          if (context.watch<MediaProvider>().currentSongPath != null &&
              MediaQuery.of(context).size.height > 250)
            Slider(
              activeColor:
                  context.watch<ColorProvider>().amplifyingColor.normalColor,
              inactiveColor:
                  context.watch<ColorProvider>().amplifyingColor.darkestColor,
              secondaryActiveColor:
                  context.watch<ColorProvider>().amplifyingColor.normalColor,
              thumbColor:
                  context.watch<ColorProvider>().amplifyingColor.accentColor,
               value: context.read<MediaProvider>().player.duration != null &&
                      currentSliderValue <=
                          context
                              .read<MediaProvider>()
                              .player
                              .duration!
                              .inMilliseconds
                              .toDouble()
                  ? currentSliderValue
                  : 0,
              max: context
                      .read<MediaProvider>()
                      .player
                      .duration
                      ?.inMilliseconds
                      .toDouble() ??
                  100,
              onChangeStart: (double value)
              {
                isChanging = true;
              },
              onChangeEnd: (double value)
              {
                isChanging = false;
              },
              //context.watch<MediaProvider>().player_.duration!.inMinutes.toDouble(),
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                if(isChanging)
                  {
                    currentSliderValue = value;
                    context.read<MediaProvider>().player.seek(Duration(milliseconds: value.round()));
                  }
                setState(() {});
              },
            ),
          if (context.watch<MediaProvider>().currentSongPath != null &&
              MediaQuery.of(context).size.width < 750 &&
              MediaQuery.of(context).size.width > 270)
            const Padding(
                padding: EdgeInsets.symmetric(vertical: 10.0),
                child: AmplifyingMediaControls()),
          if (context.watch<MediaProvider>().currentSongPath != null &&
              MediaQuery.of(context).size.height > 300)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                  height: 70,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        child: Row(
                          children: [
                            Flexible(
                                child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: AmplifyingMediaImage(
                                borderWidth: 4,
                                borderRadius: 7,
                                images: context
                                                .watch<MediaProvider>()
                                                .currentSongMetadata !=
                                            null &&
                                        context
                                                .watch<MediaProvider>()
                                                .currentSongMetadata!
                                                .picture !=
                                            null
                                    ? <ImageProvider>[
                                        Image.memory(context
                                                .watch<MediaProvider>()
                                                .currentSongMetadata!
                                                .picture!
                                                .data)
                                            .image
                                      ]
                                    : null,
                                mainOnPress: () {
                                  context.read<MediaProvider>().player.stop();
                                },
                              ),
                            )),
                            Flexible(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Flexible(
                                    child: Text(
                                      context
                                              .watch<MediaProvider>()
                                              .currentSongMetadata
                                              ?.title ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 17,
                                          color: context
                                              .watch<ColorProvider>()
                                              .amplifyingColor
                                              .whiteColor),
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      context
                                              .watch<MediaProvider>()
                                              .currentSongMetadata
                                              ?.album ??
                                          "",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: context
                                              .watch<ColorProvider>()
                                              .amplifyingColor
                                              .lightColor),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      if (MediaQuery.of(context).size.width >= 750)
                        Expanded(child: AmplifyingMediaControls()),
                      if (MediaQuery.of(context).size.width >= 500)
                        Flexible(
                            child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            if(context.watch<MediaProvider>().currentSource?.sourceName != null)
                            AmplifyingMenuItem(
                                onPressed: () {
                                  mediaPlayerController
                                      .shufflePlaylist(context);
                                },
                                icon: Icons.shuffle,
                                padding: EdgeInsets.zero,
                                preWidgetSpacer: const SizedBox(
                                  width: 0,
                                ),
                                postWidgetSpacer: const SizedBox(
                                  width: 0,
                                )),
                            if(context.watch<SettingsProvider>().useBetaFeatures)
                            AmplifyingMenuItem(
                                onPressed: () {},
                                icon: Icons.volume_up_rounded,
                                padding: EdgeInsets.zero,
                                preWidgetSpacer: const SizedBox(
                                  width: 0,
                                ),
                                postWidgetSpacer: const SizedBox(
                                  width: 0,
                                )),
                          ],
                        )),
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
