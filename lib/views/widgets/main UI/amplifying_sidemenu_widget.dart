import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../amplifying_menu_widget.dart';

class AmplifyingSideMenu extends StatelessWidget {
  const AmplifyingSideMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Flexible(
          child: ListView(
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
                    onPressed: ()=>{context.read<ColorProvider>().updateColors(Colors.red)},
                  ),
                  AmplifyingMenuItem(
                      icon: Icons.public_rounded,
                      text: "orange",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.orange)}),
                  AmplifyingMenuItem(
                      icon: Icons.public_rounded,
                      text: "yellow",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.yellow)}),
                  AmplifyingMenuItem(
                      icon: Icons.bluetooth,
                      text: "green",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.green)}),
                  AmplifyingMenuItem(
                      icon: Icons.account_tree_outlined,
                      text: "blue",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.blue)}),

                  AmplifyingMenuItem(
                      icon: Icons.account_tree_outlined,
                      text: "pink",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.pink)}),
                  AmplifyingMenuItem(
                      icon: Icons.public_rounded,
                      text: "purple",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.purple)}),

                  AmplifyingMenuItem(
                      icon: Icons.public_rounded,
                      text: "white",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.white)}),
                  AmplifyingMenuItem(
                      icon: Icons.public_rounded,
                      text: "black",
                      onPressed: () => {context.read<ColorProvider>().updateColors(Colors.black)}),
                  AmplifyingMenuItem(
                      icon: Icons.disabled_by_default,
                      text: "Default",
                      onPressed: () => {context.read<ColorProvider>().updateColors(defaultColor)}),

                ],
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
        AmplifyingMenuItem(
            icon: Icons.exit_to_app,
            text: "Exit",
            onPressed: () => {})
      ],
    );
  }
}
