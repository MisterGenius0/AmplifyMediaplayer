import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:amplifying_mediaplayer/controllers/providers/media_provider.dart';
import 'package:amplifying_mediaplayer/views/pages/Home_page.dart';
import 'package:amplifying_mediaplayer/views/pages/Settings/source_settings_Page.dart';
import 'package:amplifying_mediaplayer/views/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  late BuildContext context;
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

      },
      initialRoute: "/loading",
    ),
  ));
}
