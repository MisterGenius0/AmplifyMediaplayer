import 'dart:ui';
import 'package:flutter/cupertino.dart';
import '../models/amplifying_color_models.dart';

class ColorProvider extends ChangeNotifier
{
  AmplifyingColor amplifyingColor = AmplifyingColor();

  void UpdateColors(Color newColor)
  {
    double animationValue = 1;

    var colors = calculateColor(newColor);

    ///@TODO
    ///Setup animation and lerp the animation value 0->1 after .5 seconds
    amplifyingColor.lightColor = Color.lerp(amplifyingColor.lightColor, colors.lightColor, animationValue)!;
    amplifyingColor.normalColor = Color.lerp(amplifyingColor.normalColor, colors.normalColor, animationValue)!;
    amplifyingColor.darkColor = Color.lerp(amplifyingColor.darkColor, colors.darkColor, animationValue)!;
    amplifyingColor.darkestColor = Color.lerp(amplifyingColor.darkestColor, colors.darkestColor, animationValue)!;
    amplifyingColor.backgroundDarkColor = Color.lerp(amplifyingColor.backgroundDarkColor, colors.backgroundDarkColor, animationValue)!;
    amplifyingColor.backgroundDarkerColor = Color.lerp(amplifyingColor.backgroundDarkerColor, colors.backgroundDarkerColor, animationValue)!;
    amplifyingColor.backgroundDarkestColor = Color.lerp(amplifyingColor.backgroundDarkestColor, colors.backgroundDarkestColor, animationValue)!;
    amplifyingColor.accentColor = colors.accentColor;

    notifyListeners();
  }
}