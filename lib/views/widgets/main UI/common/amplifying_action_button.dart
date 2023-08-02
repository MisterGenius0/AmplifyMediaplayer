import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:provider/provider.dart';

class AmplifyingActionButton extends StatelessWidget {
  const AmplifyingActionButton({super.key, required this.text, required this.backgroundColor, required this.onPress});

  final String text;
  final Color backgroundColor;
  final VoidCallback? onPress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 40),
      child: TextButton(
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.resolveWith((states) => backgroundColor,),
          padding: MaterialStateProperty.resolveWith((states) => EdgeInsets.all(30),
          ),
          textStyle: MaterialStateProperty.resolveWith((states) => TextStyle(
            fontSize: 25,
            color: context
                .read<ColorProvider>()
                .amplifyingColor
                .whiteColor
          ),),

        ),
          onPressed: onPress,
          child: Text(
              text,
            style: TextStyle(
              color: context
                  .read<ColorProvider>()
                  .amplifyingColor
                  .whiteColor
            ),
          )
      ),
    );
  }
}
