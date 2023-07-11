import 'package:flutter/material.dart';

import '../amplifying_colors.dart';

class MenuSection extends StatelessWidget {
  const MenuSection(
      {super.key,
        this.title = "",
        required this.widgetList,
        required this.color});

  final String title;
  final List<Widget> widgetList;
  final AmplifyingColor color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 25,
        ),
        Text(
          title,
          style: TextStyle(color: color.accentColor, fontSize: 50),
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

class MenuItem extends StatelessWidget {
  const MenuItem(
      {super.key,
        this.icon,
        this.text,
        required this.color,
        required this.onPressed
      });

  final IconData? icon;
  final String? text;
  final AmplifyingColor color;
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
              color: color.accentColor,
            )
                : Container(),
            const SizedBox(width: 25),
            text != null
                ? Text(
              text!,
              style: TextStyle(color: color.accentColor, fontSize: 25),
            )
                : Container(),
          ],
        ),
      ),
    );
  }
}