import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';

class AmplifyingAppBar extends AppBar {
  AmplifyingAppBar({
    super.key,
    required this.context,
    super.actions,
    super.leading,
    this.primaryTitle= "Amplifying",
    this.secondaryTitle = "Media Player",
  });

  final String primaryTitle;
  final String secondaryTitle;

//Custom Overrides
  final BuildContext context;
  @override
  Widget? get title => Column(
    children: [
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(
              width: 45,
              child: Image(
                  image: AssetImage("assets/Logo.png")
              )
          ),
          Flexible(
            child: Text(
              " Amplifying",
              style: TextStyle(
                color: context.watch<ColorProvider>().amplifyingColor.lightColor,
              ),
            ),
          ),
          Flexible(
            child: Text(
              " Media Player",
              style: TextStyle(
                  color: context.watch<ColorProvider>().amplifyingColor.accentColor
              ),
            ),
          ),
              const Flexible(
                //Spaces to center the title in the navbar
              child: Text("                "),
              )
        ],
      ),
    ],
  );

  //Default overrides

  @override
  Color? get backgroundColor => context.watch<ColorProvider>().amplifyingColor.backgroundDarkerColor;
}