import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_appbar_widget.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/amplifying_color_provider.dart';
import '../../controllers/providers/media_provider.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  var color = AmplifyingColor();

  @override
  void initState() {
    super.initState();
    context.read<MediaProvider>().loadData().then((value) => Navigator.pushReplacementNamed(context, "/home"));
  }

  @override
  //Define and get color
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.watch<ColorProvider>().amplifyingColor.backgroundDarkestColor,
      appBar: AmplifyingAppBar(
        context: context,
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
                color: context.watch<ColorProvider>().amplifyingColor.accentColor,
                size: 100,
              ),
              const SizedBox(
                height: 50,
              ),
              Text(
                "   Loading...",
                style: TextStyle(color: context.watch<ColorProvider>().amplifyingColor.accentColor, fontSize: 50),
              ),
            ],
          ),
        )),
      ),
    );
  }
}
