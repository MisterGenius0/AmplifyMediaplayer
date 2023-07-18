import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../amplifying_menu_widget.dart';

class AmplifyingSideMenu extends StatelessWidget {
  const AmplifyingSideMenu({super.key});


  @override
  Widget build(BuildContext context) {
    return  ListView(
      children: [
        AmplifyingMenuSection(
          title: "Menu",
          widgetList: [
            AmplifyingMenuItem(
                icon: Icons.queue_music,
                text: "Music",
                onPressed: () => {}),
            AmplifyingMenuItem(
                icon: Icons.folder,
                text: "Sources",
                onPressed: () => {}),
            AmplifyingMenuItem(
                icon: Icons.settings,
                text: "Settings",
                onPressed: () => {}),
          ],
        ),
        AmplifyingMenuSection(
          title: "Colors",
          widgetList: [
            AmplifyingMenuItem(
              icon: Icons.reddit,
              text: "Red",
              onPressed: ()=>{context.read<ColorProvider>().UpdateColors(Colors.red)},
            ),
            AmplifyingMenuItem(
                icon: Icons.bluetooth,
                text: "Blue",
                onPressed: () => {context.read<ColorProvider>().UpdateColors(Colors.blue)}),
            AmplifyingMenuItem(
                icon: Icons.account_tree_outlined,
                text: "Green",
                onPressed: () => {context.read<ColorProvider>().UpdateColors(Colors.green)}),
            AmplifyingMenuItem(
                icon: Icons.public_rounded,
                text: "Purple",
                onPressed: () => {context.read<ColorProvider>().UpdateColors(Colors.purple)}),
            AmplifyingMenuItem(
                icon: Icons.disabled_by_default,
                text: "Default",
                onPressed: () => {context.read<ColorProvider>().UpdateColors(defaultColor)}),

          ],
        ),
        const SizedBox(height: 50),
      ],
    );
  }
}
