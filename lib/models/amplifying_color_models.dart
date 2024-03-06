import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter_color_models/flutter_color_models.dart';


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
  HslColor hslNewColor = HslColor.fromColor(newColor);
  HslColor correctedColor = HslColor(hslNewColor.hue, hslNewColor.saturation, 40);
  Color white = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 90);
  Color lighter = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 60);
  Color light = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 50);
  Color normal = hslNewColor;
  Color dark = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 30);
  Color darkest = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation,20);
  Color backgroundDark = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 15);
  Color backgroundDarker = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 10);
  Color backgroundDarkest = hslNewColor = HslColor(correctedColor.hue, correctedColor.saturation, 5);


  //Accent
  Color accentLighter = hslNewColor = HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 75);
  Color accent = hslNewColor = HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 60);
  Color accentDarker = hslNewColor = HslColor(clampDouble(correctedColor.hue +17, 0, 360), correctedColor.saturation, 50);

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
  Color whiteColor;
  Color lightColor;
  Color normalColor;
  Color darkColor;
  Color darkestColor;
  Color backgroundDarkColor;
  Color backgroundDarkerColor;
  Color backgroundDarkestColor;

  Color accentLighterColor;
  Color accentColor;
  Color accentDarkerColor;

  //Constructor
  AmplifyingColor({
    this.whiteColor = const HslColor(360, 100, 100, 255),
    this.lightColor = const HslColor(360, 100, 100, 255),
    this.normalColor = const HslColor(360, 100, 100, 255),
    this.darkColor = const HslColor(360, 100, 100, 255),
    this.darkestColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkerColor = const HslColor(360, 100, 100, 255),
    this.backgroundDarkestColor = const HslColor(360, 100, 100, 255),
    this.accentLighterColor = const HslColor(360, 100, 100, 255),
    this.accentColor = const HslColor(360, 100, 100, 255),
    this.accentDarkerColor = const HslColor(360, 100, 100, 255),
  });
}