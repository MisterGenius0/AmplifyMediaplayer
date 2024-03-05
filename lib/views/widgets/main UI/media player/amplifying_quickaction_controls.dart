import 'package:amplify/controllers/widgets/mediaPlayer/quickaction_controls_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplify/views/widgets/amplifying_menu_widget.dart';
import 'package:provider/provider.dart';

import '../../../../controllers/providers/media_provider.dart';

class QuickactionButtons extends StatelessWidget {
  const QuickactionButtons({super.key, required this.child});

  final Widget child;

  //TODO make quick action (Shuffle and play) disspear when there is no current source

  @override
  Widget build(BuildContext context) {

    QuickactionControlsController quickActionControlsController = QuickactionControlsController();
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(context.read<MediaProvider>().currentSource?.sourceName != null)
              AmplifyingMenuItem(
                  onPressed: () {quickActionControlsController.playOnPress(context);},
                  icon: Icons.play_arrow,
                  padding: EdgeInsets.zero,
                  preWidgetSpacer: const SizedBox(
                    width: 0,
                  ),
                  postWidgetSpacer: const SizedBox(
                    width: 0,
                  )),
              if(context.read<MediaProvider>().currentSource?.sourceName != null)
              AmplifyingMenuItem(
                  onPressed: () {quickActionControlsController.shuffleOnPress(context);},
                  icon: Icons.shuffle,
                  padding: EdgeInsets.zero,
                  preWidgetSpacer: const SizedBox(
                    width: 0,
                  ),
                  postWidgetSpacer: const SizedBox(
                    width: 0,
                  )),
              AmplifyingMenuItem(
                  onPressed: () {},
                  icon: Icons.view_headline,
                  padding: EdgeInsets.zero,
                  preWidgetSpacer: const SizedBox(
                    width: 0,
                  ),
                  postWidgetSpacer: const SizedBox(
                    width: 0,
                  )),
              AmplifyingMenuItem(
                  onPressed: () {},
                  icon: Icons.sort,
                  padding: EdgeInsets.zero,
                  preWidgetSpacer: const SizedBox(
                    width: 0,
                  ),
                  postWidgetSpacer: const SizedBox(
                    width: 0,
                  )),
              AmplifyingMenuItem(
                  onPressed: () {},
                  icon: Icons.filter_alt,
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
        Flexible(child: child),
      ],
    );
  }
}
