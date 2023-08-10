import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingAppBar extends AppBar {
  AmplifyingAppBar({
    super.key,
    required this.context,
    super.actions,
    this.leadingWidget,
    this.primaryTitle = "Amplifying",
    this.secondaryTitle = "Media Player",
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
              const SizedBox(
                  width: 45,
                  child: Image(image: AssetImage("assets/Logo.png"))),
              Flexible(
                child: Text(
                  " Amplifying",
                  style: TextStyle(
                    color: context
                        .watch<ColorProvider>()
                        .amplifyingColor
                        .lightColor,
                  ),
                ),
              ),
              Flexible(
                child: Text(
                  " Media Player",
                  style: TextStyle(
                      color: context
                          .watch<ColorProvider>()
                          .amplifyingColor
                          .accentColor),
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
          onPressed: () => {Navigator.pop(context)},
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
