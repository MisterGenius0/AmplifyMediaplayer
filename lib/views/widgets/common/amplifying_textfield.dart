import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'amplifying_setting_label.dart';

class AmplifyingTextField extends StatelessWidget {
  const AmplifyingTextField(
      {super.key,
      required this.controller,
      required this.onChanged,
        this.description,
        this.leadingText,
      this.initalText});

  final TextEditingController controller;
  final String? initalText;

  final ValueChanged<String>? onChanged;

  final String? leadingText;
  final String? description;

  @override
  Widget build(BuildContext context) {

   initalText != null ? controller.value = TextEditingValue(text: initalText!) : "";

    return AmplifyingSettingLabel(
      leadingText: leadingText,
      description: description,
      child: TextField(
      cursorColor: context
          .read<ColorProvider>()
          .amplifyingColor
          .accentDarkerColor,
      controller: controller,
      onChanged: onChanged,
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
