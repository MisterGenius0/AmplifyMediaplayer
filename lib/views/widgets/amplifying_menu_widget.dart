import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/models/amplifying_color_models.dart';
import 'package:provider/provider.dart';

import '../../controllers/amplifying_color_controller.dart';

class AmplifyingMenuSection extends StatelessWidget {
  const AmplifyingMenuSection(
      {super.key,
        this.title = "",
        required this.widgetList,});

  final String title;
  final List<Widget> widgetList;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: TextStyle(color: context.watch<ColorProvider>().amplifyingColor.accentColor, fontSize: 50),
        ),
        const SizedBox(
          height: 25,
        ),
        Column(children: widgetList),
        const SizedBox(
          height: 50,
        )
      ],
    );
  }
}

class AmplifyingMenuItem extends StatelessWidget {
  const AmplifyingMenuItem(
      {super.key,
        this.icon,
        this.text,
        required this.onPressed
      });

  final IconData? icon;
  final String? text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(width: 25),
            icon != null
                ? Icon(
              icon,
              size: 40,
              color: context.watch<ColorProvider>().amplifyingColor.accentColor,
            )
                : Container(),
            const SizedBox(width: 25),
            text != null
                ? Text(
              text!,
              style: TextStyle(color: context.watch<ColorProvider>().amplifyingColor.accentColor, fontSize: 25),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}