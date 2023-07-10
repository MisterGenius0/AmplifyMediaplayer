import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';

Color getDefaultColor()
{
 return (Color.fromARGB(1,194, 41, 10));
}

class AmplifyingColor {

  Color lightColor = const HslColor(10, 90, 40, 255);
  Color normalColor = const HslColor(10, 90, 40, 255);
  Color darkColor = const HslColor(10, 90, 40, 255);
  Color darkestColor = const HslColor(10, 90, 40, 255);
  Color backgroundDarkColor = const HslColor(10, 90, 40, 255);
  Color backgroundDarkerColor= const HslColor(10, 90, 40, 255);
  Color backgroundDarkestColor= const HslColor(10, 90, 40, 255);
  Color accentColor = const HslColor(1, 10, 90, 40);

  void updateColors(Color newColor)
  {
    var colors = calculateColor(newColor);

    lightColor = colors.lightColor;
    normalColor = colors.normalColor;
    darkColor = colors.darkColor;
    darkestColor = colors.darkestColor;
    backgroundDarkColor = colors.backgroundDarkColor;
    backgroundDarkerColor = colors.backgroundDarkerColor;
    backgroundDarkestColor = colors.backgroundDarkestColor;
    accentColor = colors.accentColor;
  }

  //Calculate Color function
  ({
  Color lightColor,
  Color normalColor,
  Color darkColor,
  Color darkestColor,
  Color backgroundDarkColor,
  Color backgroundDarkerColor,
  Color backgroundDarkestColor,
  Color accentColor}) calculateColor(Color newColor)
{
  HslColor hslNewColor = HslColor.fromColor(newColor);
  HslColor correctedColor = HslColor(hslNewColor.hue, hslNewColor.saturation, 40);
  Color light = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness + 10);
  Color normal = hslNewColor;
  Color dark = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness - 10);
  Color darkest = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness - 20);
  Color backgroundDark = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness - 25);
  Color backgroundDarker = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness - 30);
  Color backgroundDarkest = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, correctedColor.lightness - 35);
  Color accent = hslNewColor = HslColor(correctedColor.hue +17, correctedColor.saturation, correctedColor.lightness + 10);

  return(
  lightColor: light,
  normalColor: normal,
  darkColor: dark,
  darkestColor: darkest,
  backgroundDarkColor: backgroundDark,
  backgroundDarkerColor: backgroundDarker,
  backgroundDarkestColor: backgroundDarkest,
  accentColor: accent);

}


}