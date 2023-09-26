import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

class MediaGridItem extends StatefulWidget {
  const MediaGridItem({super.key, required this.name, required this.mainOnPress, required this.contextMenuOnPress, this.images, required this.subtext, });

 final String name;
 final String subtext;

 final List<ImageProvider>? images;

  final Function mainOnPress;

  final Function contextMenuOnPress;

  @override
  State<MediaGridItem> createState() => _MediaGridItemState();
}

class _MediaGridItemState extends State<MediaGridItem> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 10,
          child: AspectRatio(
            aspectRatio: 1/1,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                    side: BorderSide(
                        width: 15,
                        style: BorderStyle.solid,
                        color: context.watch<ColorProvider>().amplifyingColor.accentLighterColor
                    )
                ),
                color:  widget.images!.isNotEmpty  ?  context.watch<ColorProvider>().amplifyingColor.accentLighterColor : context
                    .watch<ColorProvider>()
                    .amplifyingColor
                    .backgroundDarkerColor,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextButton(
                            onPressed: (){},
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                if(widget.images!.length >= 4 && widget.images != null)
                                  widget.images!.isNotEmpty  ? Expanded(child: GridView.count(crossAxisCount:  2, children: [
                                    Image(image:  widget.images![0], fit: BoxFit.fill,),
                                    Image(image:  widget.images![1], fit: BoxFit.fill,),
                                    Image(image:  widget.images![2], fit: BoxFit.fill,),
                                    Image(image:  widget.images![3], fit: BoxFit.fill,),
                                  ],),) : Container(),
                                if(widget.images!.length < 4 && widget.images != null)
                                  widget.images!.isNotEmpty  ? Expanded(child: Image(image: (widget.images![0]), fit: BoxFit.fill,)) :
                                        FittedBox(
                                          fit: BoxFit.fill,
                                          child: IconButton(
                                            onPressed: ()=>{widget.mainOnPress},
                                            icon:  SizedBox.expand(
                                              child: Icon(Icons.library_music,
                                                  color: context
                                                      .watch<ColorProvider>()
                                                      .amplifyingColor
                                                      .accentColor),
                                            ),
                                          ),
                                        ),
                              ],
                            ),
                          ),
                        )
                        )),
          ),
        Expanded(
          flex: 1,
          child: Center(
            child: AmplifyingMenuItem(
                onPressed: () =>{widget.contextMenuOnPress},
                icon: Icons.menu,
                preWidgetSpacer: const SizedBox(),
                postWidgetSpacer: const SizedBox()),
          ),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            child: Text(
              widget.name,
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
