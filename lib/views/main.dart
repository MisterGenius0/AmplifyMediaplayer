import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/views/pages/Home.dart';
import 'package:amplifying_mediaplayer/views/pages/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ColorProvider>(create: (_)=>ColorProvider())
    ],
    child: MaterialApp(
      routes: {
        "/loading": (context) => const LoadingScreen(),
        "/home": (context) => const HomeScreen(),
      },
      initialRoute: "/home",
    ),
  ));
}
