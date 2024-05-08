import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingGridSeparator extends StatelessWidget {
  const AmplifyingGridSeparator({super.key, required this.icon,  this.label = ""});

  /// The icon for the separator
  final IconData icon;

  /// The text label for the separator
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 80, 8, 15),
      child: Container(
        color: context.watch<ColorProvider>().amplifyingColor.accentDarkerColor,
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Icon(icon, color: context.watch<ColorProvider>().amplifyingColor.whiteColor, size: 80,),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(label, style: TextStyle( fontSize: 30, color: context.watch<ColorProvider>().amplifyingColor.whiteColor),),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
