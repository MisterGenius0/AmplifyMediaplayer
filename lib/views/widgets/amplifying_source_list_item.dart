import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:provider/provider.dart';

class AmplifyingSourceListItem extends StatelessWidget {
  const AmplifyingSourceListItem({super.key, this.text = ""});

  final String text;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: context
            .read<ColorProvider>()
            .amplifyingColor
            .backgroundDarkColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                      text,
                    style: TextStyle(
                      color: context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .whiteColor,
                      fontSize: 30
                    ),
                  )),

              Flexible(
                  child: MaterialButton(
                    height: 50,
                    shape: const CircleBorder(),
                    onPressed: () => {},
                    child: Icon(
                      Icons.remove_circle, size: 40,
                      color: context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .accentColor,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
