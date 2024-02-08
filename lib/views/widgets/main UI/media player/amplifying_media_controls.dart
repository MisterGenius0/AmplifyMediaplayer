import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../amplifying_menu_widget.dart';

class AmplifyingMediaControls extends StatefulWidget {
  const AmplifyingMediaControls({super.key});

  @override
  State<AmplifyingMediaControls> createState() => _AmplifyingMediaControlsState();
}

class _AmplifyingMediaControlsState extends State<AmplifyingMediaControls> {
  @override
  Widget build(BuildContext context) {
    return  Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        AmplifyingMenuItem(
            onPressed: () {},
            icon: Icons.fast_rewind,
            padding: EdgeInsets.zero,
            preWidgetSpacer: const SizedBox(
              width: 0,
            ),
            postWidgetSpacer: const SizedBox(
              width: 0,
            )),
        AmplifyingMenuItem(
            onPressed: () {},
            icon: Icons.play_arrow,
            padding: EdgeInsets.zero,
            preWidgetSpacer: const SizedBox(
              width: 0,
            ),
            postWidgetSpacer: const SizedBox(
              width: 0,
            )),
        AmplifyingMenuItem(
            onPressed: () {},
            icon: Icons.stop,
            padding: EdgeInsets.zero,
            preWidgetSpacer: const SizedBox(
              width: 0,
            ),
            postWidgetSpacer: const SizedBox(
              width: 0,
            )),
        AmplifyingMenuItem(
            onPressed: () {},
            icon: Icons.fast_forward,
            padding: EdgeInsets.zero,
            preWidgetSpacer: const SizedBox(
              width: 0,
            ),
            postWidgetSpacer: const SizedBox(
              width: 0,
            )),
      ],
    );
  }
}
