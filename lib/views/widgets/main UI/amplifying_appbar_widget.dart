import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';

class AmplifyingAppBar extends AppBar {
  AmplifyingAppBar({
    super.key,
    required this.context,
    super.actions,
    this.leadingWidget,
    this.primaryTitle = "",
    this.secondaryTitle = "",
  });

  final String primaryTitle;
  final String secondaryTitle;
  final Widget? leadingWidget;

//Custom Overrides
  final BuildContext context;

  @override
  Widget? get title => Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if(MediaQuery.of(context).size.width > 135)
              const SizedBox(
                  width: 45,
                  child: Image(image: AssetImage("assets/logo.png"))),
              Flexible(
                child: Text(
  MediaQuery.of(context).size.width > 350?"Amplify " : "",
                  style: TextStyle(
                    color: context
                        .watch<ColorProvider>()
                        .amplifyingColor
                        .accentColor,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  MediaQuery.of(context).size.width > 490  ? "${context.watch<MediaProvider>().currentSource?.sourceName ?? "Media Player"} " : "",
                  style: TextStyle(
                      color: context
                          .watch<ColorProvider>()
                          .amplifyingColor
                          .lightColor),
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

  /// Added back arrow when there is something on the parent route
  /// if the leading widget is null, have a container
  ///
  /// TODO Make burger menu and arrow appear both on the appbar Make everything in the title and center the title insted remove everyhting from leading
  @override
  Widget? get leading => Navigator.canPop(context)
      ? IconButton(
          onPressed: () => {
           // print("Left Source: ${ModalRoute.of(context)?.settings.arguments as Map {"MediaSource"}"),
            // context.read<MediaProvider>().updatePath(context: context)

            print(ModalRoute.of(context)?.settings.name),
            if(ModalRoute.of(context)?.settings.name == "/groups")
              {
                context.read<MediaProvider>().updatePath(context: context,),

              }
            else if(ModalRoute.of(context)?.settings.name == "/media")
              {
              context.read<MediaProvider>().updatePath(context: context, mediaSource: context.read<MediaProvider>().currentSource),
              },
            Navigator.pop(context),
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: context
                .watch<ColorProvider>()
                .amplifyingColor
                .accentColor,
            size: 40,
          ))
      : leadingWidget != null
          ? leadingWidget!
          : Container();

  @override
  Color? get backgroundColor =>
      context.watch<ColorProvider>().amplifyingColor.backgroundDarkerColor;
}
