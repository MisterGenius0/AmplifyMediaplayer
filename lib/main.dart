import 'package:amplifying_mediaplayer/pages/Home.dart';
import 'package:flutter/material.dart';
import 'package:amplifying_mediaplayer/amplifying_colors.dart';
import 'package:amplifying_mediaplayer/pages/loading.dart';

void main() {
  runApp(MaterialApp(
    routes: {
      "/" : (context) =>const LoadingScreen(),
      "/home" : (context) =>const HomeScreen(),
    },
    initialRoute: "/",
  ));
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  var colors =AmplifyingColor();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
              Icons.menu
          ),
          onPressed: (){},
        ),
        title: const Text("Amplifying MediaPlayer"),
        centerTitle: true,
      backgroundColor: colors.backgroundDarkestColor
      ),
    );
  }
}
