import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingTextField extends StatelessWidget {
  const AmplifyingTextField(
      {super.key,
      required this.controller,
      required this.OnSubmit,
      this.leadingText});

  final TextEditingController controller;

  final ValueChanged<String>? OnSubmit;

  final String? leadingText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          leadingText != null
              ? Flexible(
            flex: 1,
                child: Text("$leadingText: ",
                textAlign: TextAlign.end,
                style: TextStyle(
                  fontSize: 24,
                  color: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .accentLighterColor,
                )),
              )
              : Container(),
          Flexible(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: TextField(
                cursorColor: context
                    .read<ColorProvider>()
                    .amplifyingColor
                    .accentDarkerColor,
                controller: controller,
                onSubmitted: OnSubmit,
                decoration: InputDecoration(
                  filled: true,
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(
                          color: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .whiteColor)
                  ),
                  focusColor: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .backgroundDarkColor,
                  fillColor: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .backgroundDarkColor,
                ),
                style: TextStyle(
                  fontSize: 20,
                  color: context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .whiteColor,
                ),
              ),
            ),
          ),
          //Edge padding to center the text field
          const Flexible(child: FractionallySizedBox(widthFactor: .7,))
        ],
      ),
    );
  }
}
