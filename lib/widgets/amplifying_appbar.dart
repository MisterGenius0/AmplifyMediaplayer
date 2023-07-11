import 'package:flutter/material.dart';
import '../amplifying_colors.dart';

class AmplifyingAppBar extends AppBar {
  AmplifyingAppBar({
    super.key,
    required this.color,
    super.actions,
    super.leading,
  });

//Custom Overrides
  final AmplifyingColor color;
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
          color: color.lightColor,
        ),
      ),
      Text(
        " Media Player",
        style: TextStyle(
            color: color.accentColor
        ),
      )
    ],
  );

  //Default overrides
  @override
  Widget? get leading => super.leading;

  @override
  List<Widget>? get actions => super.actions;

  @override
  Color? get backgroundColor => color.backgroundDarkerColor;
}