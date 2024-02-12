import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/models/amplifying_color_models.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

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
                      onPressed: () => {context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/home"))}),
                  AmplifyingMenuItem(
                      icon: Icons.favorite,
                      text: "Favorites",
                      onPressed: () => {}),
                  AmplifyingMenuItem(
                      icon: Icons.settings,
                      text: "Settings",
                      onPressed: () => {print("Settings pressed"), context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/settings"))}),
                ],
              ),
              const SizedBox(height: 50),
              AmplifyingMenuSection(
                title: "Admin",
                widgetList: [
                  AmplifyingMenuItem(
                      icon: Icons.supervised_user_circle,
                      text: "Users",
                      onPressed: () => {context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/home"))}),
                  AmplifyingMenuItem(
                      icon: Icons.terminal,
                      text: "Terminal",
                      onPressed: () => {}),
                ],
              ),
            ],
          ),
        ),
    if(MediaQuery.of(context).size.height > 150)
    AmplifyingMenuItem(
            icon: Icons.exit_to_app,
            backgroundColor: context.read<ColorProvider>().amplifyingColor.backgroundDarkColor,
            text: "Exit",
            onPressed: () => {})
      ],
    );
  }
}
