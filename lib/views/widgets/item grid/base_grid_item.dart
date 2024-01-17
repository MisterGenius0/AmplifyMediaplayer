import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/item%20grid/media_grid_item_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseGridItem extends StatefulWidget {
  const BaseGridItem({
    super.key,
    this.child,
    this.title,
    required this.mainOnPress,
    this.contextMenuOnPress,
    this.images,
    this.icon = Icons.library_music,
    this.subtext,
  });

  final String? title;
  final String? subtext;
  final Widget? child;

  final List<ImageProvider>? images;

  final IconData? icon;

  final Function mainOnPress;

  final Function? contextMenuOnPress;

  @override
  State<BaseGridItem> createState() => _BaseGridItemState();
}

class _BaseGridItemState extends State<BaseGridItem> {
  bool FillSquare = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 10,
          child: AspectRatio(
              aspectRatio: 1 / 1,
              child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(
                          width: 9,
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
                    onPressed: () {
                      widget.mainOnPress();
                    },
                    child: widget.child ??
                        (widget.images != null && widget.images!.isNotEmpty
                            ? GridItemImage(images: widget.images,)
                            : SizedBox.expand(child: FittedBox(
                          fit: BoxFit.fitWidth,
                          child:
                             Padding(
                               padding: const EdgeInsets.all(8.0),
                               child: Icon(widget.icon,
                                    color: context
                                        .watch<ColorProvider>()
                                        .amplifyingColor
                                        .accentColor),
                             ),
                        ),)),
                  ))),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
            fit: BoxFit.fitWidth,
            child: TextButton(
              style: TextButton.styleFrom(
                  padding: EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed:
                  (widget.title != null) && (widget.contextMenuOnPress != null)
                      ? () => {widget.contextMenuOnPress!()}
                      : null,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(widget.title ?? " ",
                    style: TextStyle(
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .whiteColor)),
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: FittedBox(
            fit: BoxFit.fill,
            child: TextButton(
              isSemanticButton: false,
              style: TextButton.styleFrom(
                  padding: const EdgeInsets.fromLTRB(10.0, 3.0, 10.0, 3.0),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  alignment: Alignment.centerLeft),
              onPressed: (widget.subtext != null) &&
                      (widget.contextMenuOnPress != null)
                  ? () => {widget.contextMenuOnPress!()}
                  : null,
              child: FittedBox(
                fit: BoxFit.fitWidth,
                child: Text(widget.subtext ?? " ",
                    style: TextStyle(
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .lightColor)),
              ),
            ),
          ),
        )
      ],
    );
  }
}
