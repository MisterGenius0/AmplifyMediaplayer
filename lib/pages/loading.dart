import 'package:amplifying_mediaplayer/amplifying_colors.dart';
import 'package:amplifying_mediaplayer/widgets/amplifying_appbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingScreen extends StatefulWidget {
  const LoadingScreen({super.key});

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  var color = AmplifyingColor();

  @override
  //Define and get color
  Widget build(BuildContext context) {
    color.updateColors(defaultColor);

    return Scaffold(
      backgroundColor: color.backgroundDarkestColor,
      appBar: AmplifyingAppBar(
        color: color,
      ),
      body: SafeArea(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Image(image: AssetImage("assets/Logo.png")),
              const SizedBox(
                height: 40,
              ),
              SpinKitRing(
                color: color.normalColor,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "   Loading...",
                style: TextStyle(color: color.accentColor, fontSize: 50),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
