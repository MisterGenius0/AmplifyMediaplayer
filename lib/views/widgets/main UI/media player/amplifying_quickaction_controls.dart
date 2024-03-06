import 'package:amplify/controllers/widgets/mediaPlayer/quickaction_controls_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplify/views/widgets/amplifying_menu_widget.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/media_provider.dart';

import 'package:amplify/controllers/providers/settings_provider.dart';

class QuickActionButtons extends StatefulWidget {
  const QuickActionButtons({super.key, required this.child});

  final Widget child;

  @override
  State<QuickActionButtons> createState() => _QuickActionButtonsState();
}

class _QuickActionButtonsState extends State<QuickActionButtons> {
  //TODO make quick action (Shuffle and play) disspear when there is no current source
  @override
  Widget build(BuildContext context) {
    QuickActionControlsController quickActionControlsController = QuickActionControlsController();
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
              if(context.watch<MediaProvider>().currentSource?.sourceName != null)
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
                  onPressed: () {setState(() {
                    context.read<MediaProvider>().updateState();
                  });},
                  icon: Icons.refresh,
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
                  icon: Icons.view_headline,
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
                  icon: Icons.sort,
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
        Flexible(child: widget.child),
      ],
    );
  }
}
