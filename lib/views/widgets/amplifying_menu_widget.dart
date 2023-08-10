import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/providers/amplifying_color_provider.dart';

class AmplifyingMenuSection extends StatelessWidget {
  const AmplifyingMenuSection({
    super.key,
    this.title = "",
    required this.widgetList,
  });

  ///The main text in the widget
  final String title;

  ///The list of widgets to be under the title,
  ///This widget was designed to have [AmplifyingMenuItem] under it
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
          style: TextStyle(
              color: context.watch<ColorProvider>().amplifyingColor.accentColor,
              fontSize: 50),
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
  const AmplifyingMenuItem({
    super.key,
    required this.onPressed,
    this.icon,
    this.text,
    this.padding = const EdgeInsets.all(8),
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.iconSize = 40,
    this.fontSize = 25,
    this.preWidgetSpacer = const SizedBox(
        width: 25
    ),
    this.imageSpacer = const SizedBox(
      width: 25,
    ),
    this.postWidgetSpacer = const SizedBox(
      width: 25,
    ),
  });

  ///The icon in the widget next to the text
  final IconData? icon;

  /// The text next to the icon in the Widget
  final String? text;

  ///The function called when this widget is clicked or tapped
  final VoidCallback? onPressed;

  /// The padding around the element
  final EdgeInsets padding;

  /// This is the horizontal alignment
  final CrossAxisAlignment crossAxisAlignment;

  /// This is the vertical alignment
  final MainAxisAlignment mainAxisAlignment;

  ///The size of the icon
  final double iconSize;

  ///The size of the text in the widget
  final double fontSize;

  ///This is the spacing before the Widget
  ///
  /// [{PreWidgetSpacer} Icon {ImageSpacer} Text {postWidgetSpacer}]
  final SizedBox preWidgetSpacer;

  /// This is spacing between image and text
  ///
  /// [{PreWidgetSpacer} Icon {ImageSpacer} Text {postWidgetSpacer}]
  ///
  /// NOTE: this is not used when there is no text in the widget or no icon
  final SizedBox imageSpacer;

  ///This is the spacer at the end of the widget
  ///
  /// [{PreWidgetSpacer} Icon {imageSpacer} Text {postWidgetSpacer}]
  ///
  final SizedBox postWidgetSpacer;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextButton(
        onPressed: onPressed,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            preWidgetSpacer,
            icon != null
                ? Row(
                    children: [
                      Icon(
                        icon,
                        size: iconSize,
                        color: context.watch<ColorProvider>().amplifyingColor.accentLighterColor,
                      ),
                    ],
                  )
                : Container(),
            text != null && icon != null ? imageSpacer : Container(),
            text != null
                ? Text(
                    text!,
                    style: TextStyle(
                        color: context.watch<ColorProvider>().amplifyingColor.accentLighterColor,
                        fontSize: fontSize),
                  )
                : Container(),
            postWidgetSpacer
          ],
        ),
      ),
    );
  }
}
