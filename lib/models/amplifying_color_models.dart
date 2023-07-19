import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_color_models/flutter_color_models.dart';


///Defines the default color used
Color defaultColor = const Color.fromARGB(1,194, 41, 10);

({
  ///The lighter color for accents
Color lightColor,

/// The normal color, most commonly used color
/// good for generic text
Color normalColor,

/// darker color used for backgrounds and navbar
Color darkColor,

///An even darker color used for almost backgrounds
Color darkestColor,

///The lighest color used for backgrounds
Color backgroundDarkColor,

///A darker color used in background but still need to stand out
Color backgroundDarkerColor,

///The darkest color for background, this is used as the main background
Color backgroundDarkestColor,

///This color stands out the most, it is the only color with a hue shift.
///This color should be used to stand out to the user
Color accentColor})

/// This inputs a base color and outputs an [AmplifyingColor] with all the colors corrected based on the input color
/// It adjusts saturation and brightness to return a couple variations of color used in different parts of the app
calculateColor(Color newColor)
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

///This is a class to hold all color data in one data object
///
///Default color is:
///   this.lightColor = HslColor(360, 100, 100, 255),
//     this.normalColor =  HslColor(360, 100, 100, 255),
//     this.darkColor =  HslColor(360, 100, 100, 255),
//     this.darkestColor =  HslColor(360, 100, 100, 255),
//     this.backgroundDarkColor =  HslColor(360, 100, 100, 255),
//     this.backgroundDarkerColor =  HslColor(360, 100, 100, 255),
//     this.backgroundDarkestColor =  HslColor(360, 100, 100, 255),
//     this.accentColor =  HslColor(360, 100, 100, 255),
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
    this.lightColor = const HslColor(360, 100, 100, 255),
    this.normalColor = const HslColor(360, 100, 100, 255),
    this.darkColor = const HslColor(360, 100, 100, 255),
    this.darkestColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkerColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkestColor = const HslColor(360, 100, 100, 255),
    this.accentColor = const HslColor(360, 100, 100, 255),
  });
}