import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';


///Defines the default color used
Color defaultColor = const Color.fromARGB(1,194, 41, 10);
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

class AmplifyingColor {
  Color lightColor;
  Color normalColor;
  Color darkColor;
  Color darkestColor;
  Color backgroundDarkColor;
  Color backgroundDarkerColor;
  Color backgroundDarkestColor;

  Color accentColor;

  //Constructor
  AmplifyingColor({
    this.lightColor = const HslColor(10, 90, 50, 255),
    this.normalColor = const HslColor(10, 90, 40, 255),
    this.darkColor = const HslColor(10, 90, 30, 255),
    this.darkestColor = const HslColor(10, 90, 20, 255),
    this.backgroundDarkColor = const HslColor(10, 90, 15, 255),
    this.backgroundDarkerColor = const HslColor(10, 90, 10, 255),
    this.backgroundDarkestColor = const HslColor(10, 90, 5, 255),
    this.accentColor = const HslColor(27, 90, 50, 255),
  })
  {}
}