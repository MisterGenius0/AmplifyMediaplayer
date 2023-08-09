import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amplifying_setting_label.dart';

class AmplifyingTextField extends StatelessWidget {
  const AmplifyingTextField(
      {super.key,
      required this.controller,
      required this.onSubmit,
        this.description,
        this.leadingText});

  final TextEditingController controller;

  final ValueChanged<String>? onSubmit;

  final String? leadingText;
  final String? description;

  @override
  Widget build(BuildContext context) {

    return AmplifyingSettingLabel(
      leadingText: leadingText,
      description: description,
      child: TextField(
      cursorColor: context
          .read<ColorProvider>()
          .amplifyingColor
          .accentDarkerColor,
      controller: controller,
      onSubmitted: onSubmit,
        style: TextStyle(
          fontSize: 20,
          color: context
              .read<ColorProvider>()
              .amplifyingColor
              .whiteColor,
        ),
      decoration: InputDecoration(
        filled: true,
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 0,
                color: context
                    .read<ColorProvider>()
                    .amplifyingColor
                    .backgroundDarkColor)
        ),
        focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: context
                    .read<ColorProvider>()
                    .amplifyingColor
                    .backgroundDarkColor),

        ),
        errorBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: context
                  .read<ColorProvider>()
                  .amplifyingColor
                  .backgroundDarkColor),

        ),
        disabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(
              color: context
                  .read<ColorProvider>()
                  .amplifyingColor
                  .backgroundDarkColor),
        ),
        fillColor: context
            .read<ColorProvider>()
            .amplifyingColor
            .backgroundDarkColor,
      ),
    ),
    );
  }
}
