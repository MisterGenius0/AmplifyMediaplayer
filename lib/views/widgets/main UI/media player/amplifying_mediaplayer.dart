import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/views/widgets/common/amplifying_media_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';

class AmplifyingMediaPlayer extends StatefulWidget {
  const AmplifyingMediaPlayer({super.key, required this.main});

  final Widget main;

  @override
  State<AmplifyingMediaPlayer> createState() => _AmplifyingMediaPlayerState();
}

class _AmplifyingMediaPlayerState extends State<AmplifyingMediaPlayer> {
  @override
  Widget build(BuildContext context) {
    double currentSliderValue = 10;//context.watch<MediaProvider>().player_.position.inMinutes.toDouble();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(child: widget.main),
        if (context.watch<MediaProvider>().currentSongPath != null)
        Padding(
          padding: const EdgeInsets.only(left: 25, right: 25),
          child: Slider(
            activeColor: context
          .watch<ColorProvider>()
          .amplifyingColor
          .normalColor,

            inactiveColor: context
                .watch<ColorProvider>()
                .amplifyingColor
                .darkestColor,
            secondaryActiveColor: context
                .watch<ColorProvider>()
                .amplifyingColor
                .normalColor,
            thumbColor: context
                .watch<ColorProvider>()
                .amplifyingColor
                .accentColor,
            value: currentSliderValue,
            max: 100 ,//context.watch<MediaProvider>().player_.duration!.inMinutes.toDouble(),
            label: currentSliderValue.round().toString(),
            onChanged: (double value) {
              setState(() {
              });
            },
          ),
        ),
        if (context.watch<MediaProvider>().currentSongPath != null)
          Padding(
            padding: const EdgeInsets.only(bottom: 15),
            child: SizedBox(
                height: 100,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Flexible(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 35),
                          child: AmplifyingMediaImage(
                      images:
                            context.watch<MediaProvider>().currentSongMetadata !=
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
                          context.read<MediaProvider>().StopMusic();
                      },
                    ),
                        )),
                    Flexible(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
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
                          Text(
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
                          )
                        ],
                      ),
                    )
                  ],
                )),
          ),
      ],
    );
  }
}
