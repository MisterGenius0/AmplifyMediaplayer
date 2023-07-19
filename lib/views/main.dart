import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/views/pages/Home_page.dart';
import 'package:amplifying_mediaplayer/views/pages/loading_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
