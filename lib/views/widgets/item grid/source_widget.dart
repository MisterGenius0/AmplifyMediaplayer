import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Source extends StatelessWidget {
  const Source({super.key, required this.onClick, this.label});

  final String? label;
  final VoidCallback? onClick;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 4,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      width: 5,
                      style: BorderStyle.solid,
                      color: context.watch<ColorProvider>().amplifyingColor.accentLighterColor
                  )
              ),
              color: context
                  .watch<ColorProvider>()
                  .amplifyingColor
                  .backgroundDarkerColor,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    onPressed: onClick,
                    icon: Icon(Icons.add_circle,
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor),
                  ))),
        ),
        Expanded(
          flex: 1,
          child: label != null ? FittedBox(
            child: Text(
              label!,
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .whiteColor),
            ),
          ) : Container(),
        )
      ],
    );
  }
}
