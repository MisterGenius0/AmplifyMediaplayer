import 'package:amplify/views/pages/Home_page.dart';
import 'package:amplify/views/pages/Settings/source_settings_Page.dart';
import 'package:amplify/views/pages/loading_page.dart';
import 'package:amplify/views/sub_page/groups_subpage.dart';
import 'package:flutter/material.dart';
import 'package:metadata_god/metadata_god.dart';
import 'package:provider/provider.dart';

import 'controllers/providers/amplifying_color_provider.dart';
import 'controllers/providers/media_provider.dart';

void main() {
  MetadataGod.initialize();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ColorProvider>(create: (_)=>ColorProvider()),
      ChangeNotifierProvider<MediaProvider>(create: (_)=>MediaProvider()),
    ],
    child: MaterialApp(
      routes: {
        "/loading": (context) => const LoadingPage(),
        "/home": (context) => const HomePage(),
        "/source settings": (context) => const SourceSettingsPage(),
        "/groups": (context) => const GroupsSubpage(),
      },
      initialRoute: "/loading",
    ),
  ));
}
