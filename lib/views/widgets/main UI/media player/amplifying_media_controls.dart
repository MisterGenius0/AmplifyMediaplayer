import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/controllers/widgets/mediaPlayer/media_controls_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

class AmplifyingMediaControls extends StatefulWidget {
  const AmplifyingMediaControls({super.key});

  @override
  State<AmplifyingMediaControls> createState() =>
      _AmplifyingMediaControlsState();
}

class _AmplifyingMediaControlsState extends State<AmplifyingMediaControls> {
  @override
  Widget build(BuildContext context) {
    MediaControlsController controlsController = MediaControlsController();
    return SizedBox(
      height: 70,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Flexible(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if(context.read<MediaProvider>().mediaPlaylist.length > 2)
                AmplifyingMenuItem(
                    onPressed: () {controlsController.pressRewind(context);},
                    icon: Icons.fast_rewind,
                    padding: EdgeInsets.zero,
                    preWidgetSpacer: const SizedBox(
                      width: 0,
                    ),
                    postWidgetSpacer: const SizedBox(
                      width: 0,
                    )),
                if(context.read<MediaProvider>().mediaPlaylist.length <= 1)
                  AmplifyingMenuItem(
                      onPressed: () {controlsController.pressRestart(context);},
                      icon: Icons.restart_alt,
                      padding: EdgeInsets.zero,
                      preWidgetSpacer: const SizedBox(
                        width: 0,
                      ),
                      postWidgetSpacer: const SizedBox(
                        width: 0,
                      )),
                AmplifyingMenuItem(
                    onPressed: () {controlsController.pressPausePlay(context);},
                    icon: context.read<MediaProvider>().player.playing ? Icons.pause : Icons.play_arrow,
                    padding: EdgeInsets.zero,
                    preWidgetSpacer: const SizedBox(
                      width: 0,
                    ),
                    postWidgetSpacer: const SizedBox(
                      width: 0,
                    )),
                AmplifyingMenuItem(
                    onPressed: () {controlsController.pressStop(context);},
                    icon: Icons.stop,
                    padding: EdgeInsets.zero,
                    preWidgetSpacer: const SizedBox(
                      width: 0,
                    ),
                    postWidgetSpacer: const SizedBox(
                      width: 0,
                    )),
                if(context.read<MediaProvider>().mediaPlaylist.length > 2)
                AmplifyingMenuItem(
                    onPressed: () {controlsController.pressFastForward(context);},
                    icon: Icons.fast_forward,
                    padding: EdgeInsets.zero,
                    preWidgetSpacer: const SizedBox(
                      width: 0,
                    ),
                    postWidgetSpacer: const SizedBox(
                      width: 0,
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 5, top: 1.0),
            child: Text(
                "${context.watch<MediaProvider>().player.position.toString().characters.take(7)} / ${context.watch<MediaProvider>().player.duration.toString().characters.take(7)}",
            style: TextStyle(
                fontSize: 15,
                color: context
                    .watch<ColorProvider>()
                    .amplifyingColor
                    .lightColor),),
          ),
        ],
      ),
    );
  }
}
