import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';
import 'package:provider/provider.dart';

import '../../controllers/amplifying_color_controller.dart';

class AmplifyingAppBar extends AppBar {
  AmplifyingAppBar({
    super.key,
    required this.context,
    super.actions,
    super.leading,
  });

//Custom Overrides
  final BuildContext context;
  @override
  Widget? get title => Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      const SizedBox(
          width: 45,
          child: Image(
              image: AssetImage("assets/Logo.png")
          )
      ),
      Text(
        " Amplifying",
        style: TextStyle(
          color: context.watch<ColorProvider>().amplifyingColor.lightColor,
        ),
      ),
      Text(
        " Media Player",
        style: TextStyle(
            color: context.watch<ColorProvider>().amplifyingColor.accentColor
        ),
      )
    ],
  );

  //Default overrides

  @override
  Color? get backgroundColor => context.watch<ColorProvider>().amplifyingColor.backgroundDarkerColor;
}