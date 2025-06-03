import 'dart:ui';

import 'package:color_models/color_models.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


///Defines the default color used
Color defaultColor = const Color.fromARGB(1,194, 41, 10);

({

///The lighter color for accents
Color whiteColor,

///The lighter color for accents
Color lighterColor,

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
///This color should be used to stand out to the user,
///Is best used for text and main UI elements
Color accentLighterColor,

///This color stands out the most, it is the only color with a hue shift.
///This color should be used to stand out to the user,
///!!Can be hard to see in some colors!!
Color accentColor,

///This color stands out the most, it is the only color with a hue shift.
///This color should be used to stand out to the user,
///!!Can be hard to see in some colors!!
///
Color accentDarkerColor,
})

/// This inputs a base color and outputs an [AmplifyingColor] with all the colors corrected based on the input color
/// It adjusts saturation and brightness to return a couple variations of color used in different parts of the app
///Normal color starts at 40 lightness
calculateColor(Color newColor)
{
  if (kDebugMode) {
    print("calculated new color: $newColor");
  }

  HslColor hslNewColor = ColorConverter.rgbToHsl(RgbColor(newColor.red, newColor.green, newColor.blue));
  HslColor correctedColor = HslColor(hslNewColor.hue, hslNewColor.saturation, 40);
  Color white = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, 90), 1);
  Color lighter  = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, 60), 1);
  Color light  = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, 50), 1);
  Color normal = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, hslNewColor.lightness) , 1);
  Color dark = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, 30), 1);
  Color darkest = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation,20), 1);
  Color backgroundDark = hslToColor(HslColor(hslNewColor.hue, hslNewColor.saturation, 15), 1);
  Color backgroundDarker = hslToColor(HslColor(correctedColor.hue, correctedColor.saturation, 10), 1);
  Color backgroundDarkest = hslToColor(HslColor(correctedColor.hue, correctedColor.saturation, 5), 1);


  //Accent
  Color accentLighter = hslToColor(HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 75), 1);
  Color accent = hslToColor(HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 60),1);
  Color accentDarker = hslToColor(HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 50), 1);
   return(
  whiteColor: white,
  lighterColor: lighter,
  lightColor: light,
  normalColor: normal,
  darkColor: dark,
  darkestColor: darkest,
  backgroundDarkColor: backgroundDark,
  backgroundDarkerColor: backgroundDarker,
  backgroundDarkestColor: backgroundDarkest,
   accentLighterColor: accentLighter,
  accentColor: accent,
   accentDarkerColor: accentDarker,
   );

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
  Color whiteColor = hslToColor(const HslColor(360, 100, 100, 255), 1);
  Color lightColor = hslToColor(const HslColor(360, 100, 100, 255), 1);
  Color normalColor = hslToColor(const HslColor(360, 100, 100, 255), 1);
  Color darkColor = hslToColor(const HslColor(360, 100, 100, 255), 1);
  Color darkestColor = hslToColor(const HslColor(360, 100, 100, 255), 1);
  Color backgroundDarkColor;
  Color backgroundDarkerColor;
  Color backgroundDarkestColor;

  Color accentLighterColor;
  Color accentColor;
  Color accentDarkerColor;

  //Constructor
  AmplifyingColor({
    this.whiteColor = Colors.white,
    this.lightColor = Colors.white,//const HslColor(360, 100, 100, 255),
    this.normalColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.darkColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.darkestColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.backgroundDarkColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.backgroundDarkerColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.backgroundDarkestColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.accentLighterColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.accentColor = Colors.white, //const HslColor(360, 100, 100, 255),
    this.accentDarkerColor = Colors.white, //const HslColor(360, 100, 100, 255),
  });
}

Color hslToColor(HslColor hslColor, double opacity)
{
  RgbColor colorConverted = ColorConverter.hslToRgb(hslColor);
  return Color.fromRGBO(colorConverted.red, colorConverted.green, colorConverted.blue, opacity);
}
