/*TODO Exstract image code form grid item and have a square where you have a border
and image changes to icon if there is no image,
like the grid item with no clicking and subtext
 */

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/item%20grid/amplifying_grid_item_image.dart';


class AmplifyingMediaImage extends StatelessWidget {
  const AmplifyingMediaImage({super.key, this.child, this.icon = Icons.library_music, this.images, this.borderWidth = 4.5, required this.mainOnPress});

  final Widget? child;
  final List<ImageProvider>? images;
  final IconData? icon;
  final double borderWidth;
  final Function mainOnPress;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
          aspectRatio: 1 / 1,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      width: borderWidth,
                      style: BorderStyle.solid,
                      color: context
                          .watch<ColorProvider>()
                          .amplifyingColor
                          .accentLighterColor)),
              color: context
                  .watch<ColorProvider>()
                  .amplifyingColor
                  .backgroundDarkerColor,
              child: TextButton(
                clipBehavior: Clip.antiAlias,
                //TODO make play and pause when pressed button
                onPressed: ()=>{mainOnPress()},
                child: child ??
                    (images != null && images!.isNotEmpty
                        ? AmplifyingGridItemImage(images: images,)
                        : SizedBox.expand(child: FittedBox(
                      fit: BoxFit.fitWidth,
                      child:
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(icon,
                            color: context
                                .watch<ColorProvider>()
                                .amplifyingColor
                                .accentColor),
                      ),
                    ),)),
              ))),
    );
  }
}
