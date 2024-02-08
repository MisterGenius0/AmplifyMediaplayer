import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
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
  @override
  Widget build(BuildContext context) {
    double currentSliderValue = context
        .read<MediaProvider>()
        .player
        .position
        .inMilliseconds
        .toDouble(); //context.watch<MediaProvider>().player_.position.inMinutes.toDouble();
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(child: widget.main),
          if (context.watch<MediaProvider>().currentSongPath != null)
            Slider(
              activeColor:
                  context.watch<ColorProvider>().amplifyingColor.normalColor,
              inactiveColor:
                  context.watch<ColorProvider>().amplifyingColor.darkestColor,
              secondaryActiveColor:
                  context.watch<ColorProvider>().amplifyingColor.normalColor,
              thumbColor:
                  context.watch<ColorProvider>().amplifyingColor.accentColor,
              value: currentSliderValue,
              max: context
                      .read<MediaProvider>()
                      .player
                      .duration
                      ?.inMilliseconds
                      .toDouble() ??
                  100,
              //context.watch<MediaProvider>().player_.duration!.inMinutes.toDouble(),
              label: currentSliderValue.round().toString(),
              onChanged: (double value) {
                setState(() {});
              },
            ),
          Padding(
            padding: EdgeInsets.only(bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(child: Text("${context.watch<MediaProvider>().player.position}")),
                Flexible(child: Text("${context.watch<MediaProvider>().player.position} / ${context.watch<MediaProvider>().player.duration}")),
                Flexible(child: Text("${context.watch<MediaProvider>().player.duration}"),)
              ],
            ),
          ),
          if(MediaQuery.of(context).size.width < 800)
          const Padding(
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: AmplifyingMediaControls()
          ),
          if (context.watch<MediaProvider>().currentSongPath != null)
            Padding(
              padding: const EdgeInsets.only(bottom: 15),
              child: SizedBox(
                  height: 100,
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
                                borderRadius: 10,
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
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                          fontSize: 20,
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
                      if(MediaQuery.of(context).size.width >= 800)
                      Expanded(child: AmplifyingMediaControls()),
                      if(MediaQuery.of(context).size.width >= 500)
                      Flexible(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
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
                        )
                      ),
                    ],
                  )),
            ),
        ],
      ),
    );
  }
}
