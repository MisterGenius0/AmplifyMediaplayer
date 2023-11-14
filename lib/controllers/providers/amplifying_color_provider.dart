import 'package:flutter/cupertino.dart';
import 'package:amplify/models/amplifying_color_models.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

///TODO make a color to change when background is too dark be white, when background is light be black

///[ColorProvider] Handles all the color info for the app.
///You can call [updateColors] to update and change the root color for the app,
///During [updateColors] the app will rebuild most widgets and apply a new theme based on the new color
///
/// you can also Watch a color value by doing:
/// context.Watch<ColorProvider>().[AmplifyingColor].X
class ColorProvider extends ChangeNotifier
{
  ColorProvider()
  {
    updateColors(defaultColor);
  }

  ///[AmplifyingColor] holds color data for the app.
  ///You can watch amplifying color to make the widget update the color when [updateColors] is called.
  AmplifyingColor amplifyingColor = AmplifyingColor();
  ThemeData currentTheme  = ThemeData.dark();
  PaletteGenerator generator = PaletteGenerator.fromColors([]);

  ///This sets the color for the whole app theme, it will update all widgets watching [AmplifyingColor]
  void updateColors(Color newColor)
  {
    double animationValue = 1;
    print("Set Color${newColor}");

    var colors = calculateColor(newColor);

    ///@ TODO Setup animation and lerp the animation value 0->1 after .5 seconds
    ///TODO Setup adapting color - normal - based on normal color
    ///TODO setup adapting color - accent - based on accent color
    amplifyingColor.whiteColor = Color.lerp(amplifyingColor.whiteColor, colors.whiteColor, animationValue)!;
    amplifyingColor.lightColor = Color.lerp(amplifyingColor.lightColor, colors.lightColor, animationValue)!;
    amplifyingColor.normalColor = Color.lerp(amplifyingColor.normalColor, colors.normalColor, animationValue)!;
    amplifyingColor.darkColor = Color.lerp(amplifyingColor.darkColor, colors.darkColor, animationValue)!;
    amplifyingColor.darkestColor = Color.lerp(amplifyingColor.darkestColor, colors.darkestColor, animationValue)!;
    amplifyingColor.backgroundDarkColor = Color.lerp(amplifyingColor.backgroundDarkColor, colors.backgroundDarkColor, animationValue)!;
    amplifyingColor.backgroundDarkerColor = Color.lerp(amplifyingColor.backgroundDarkerColor, colors.backgroundDarkerColor, animationValue)!;
    amplifyingColor.backgroundDarkestColor = Color.lerp(amplifyingColor.backgroundDarkestColor, colors.backgroundDarkestColor, animationValue)!;
    amplifyingColor.accentLighterColor = Color.lerp(amplifyingColor.accentLighterColor, colors.accentLighterColor, animationValue)!;
    amplifyingColor.accentColor = Color.lerp(amplifyingColor.accentColor, colors.accentColor, animationValue)!;
    amplifyingColor.accentDarkerColor = Color.lerp(amplifyingColor.accentDarkerColor, colors.accentDarkerColor, animationValue)!;

    notifyListeners();
  }

  void updateWithPalette(PaletteGenerator paletteGenerator)
  {
    generator = paletteGenerator;

    updateColors(paletteGenerator.dominantColor!.color);

    notifyListeners();
  }
}