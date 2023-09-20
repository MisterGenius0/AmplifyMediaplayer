import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

class BaseMediaButton extends StatefulWidget {
  const BaseMediaButton({super.key, required this.name, required this.mainOnPress, required this.contextMenuOnPress, this.pictures, required this.subtext, });

 final String name;
 final String subtext;

 final List<Picture>? pictures;

  final Function mainOnPress;

  final Function contextMenuOnPress;

  @override
  State<BaseMediaButton> createState() => _BaseMediaButtonState();
}

class _BaseMediaButtonState extends State<BaseMediaButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 20,
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
                  child: widget.pictures != null ? Container()
                      : IconButton(
                    onPressed: ()=>{widget.mainOnPress},
                    icon: Icon(Icons.library_music,
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor),
                  ))),
        ),
        Center(
          child: AmplifyingMenuItem(
              onPressed: () =>{widget.contextMenuOnPress},
              icon: Icons.menu,
              preWidgetSpacer: const SizedBox(),
              postWidgetSpacer: const SizedBox()),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            child: Text(
              widget.name,
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
