import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

import 'package:amplify/controllers/providers/settings_provider.dart';

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
                      borderRadius: 0,
                      icon: Icons.queue_music,
                      text: "Music",
                      onPressed: () => {context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/home"))}),
                  if(context.watch<SettingsProvider>().useBetaFeatures)
                  AmplifyingMenuItem(
                      borderRadius: 0,
                      icon: Icons.favorite,
                      text: "Favorites",
                      onPressed: () => {}),
                  // AmplifyingMenuItem(
                  //     borderRadius: 0,
                  //     icon: Icons.settings,
                  //     text: "Settings",
                  //     onPressed: () => {print("Settings pressed"), context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/settings"))}),
                ],
              ),
              const SizedBox(height: 50),
              if(context.watch<SettingsProvider>().useBetaFeatures)
              AmplifyingMenuSection(
                title: "Admin",
                widgetList: [
                  AmplifyingMenuItem(
                      borderRadius: 0,
                      icon: Icons.supervised_user_circle,
                      text: "Users",
                      onPressed: () => {context.read<MediaProvider>().loadData(context).then((value) => Navigator.pushReplacementNamed(context, "/home"))}),
                  AmplifyingMenuItem(
                      borderRadius: 0,
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
        borderRadius: 0,
        icon: Icons.exit_to_app,
        backgroundColor: context.read<ColorProvider>().amplifyingColor.backgroundDarkColor,
        text: "Exit",
        onPressed: () => {})
      ],
    );
  }
}
