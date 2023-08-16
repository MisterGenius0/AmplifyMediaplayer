import 'package:amplify/models/Source_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/amplifying_color_provider.dart';
import '../amplifying_menu_widget.dart';

class Source extends StatelessWidget {
  const Source({super.key, required this.onClick, required this.mediaSource});

  final MediaSource mediaSource;
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
                    onPressed: ()=>{},
                    icon: Icon(Icons.add_circle,
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor),
                  ))),
        ),
        Center(
          child: AmplifyingMenuItem(
              onPressed: () => onClick!(),
              icon: Icons.settings,
              preWidgetSpacer: const SizedBox(),
              postWidgetSpacer: const SizedBox()),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            child: Text(
              mediaSource.sourceName,
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
