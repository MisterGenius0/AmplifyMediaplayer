import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/main%20UI/media%20player/amplifying_media_image.dart';
import 'package:amplify/views/widgets/item%20grid/amplifying_grid_item_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingBaseGridItem extends StatefulWidget {
  const AmplifyingBaseGridItem({
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
  State<AmplifyingBaseGridItem> createState() => _AmplifyingBaseGridItemState();
}

class _AmplifyingBaseGridItemState extends State<AmplifyingBaseGridItem> {
  bool FillSquare = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          flex: 10,
          child: AmplifyingMediaImage(mainOnPress: (){widget.mainOnPress();}, images: widget.images, icon: widget.icon,),
        ),
        Expanded(
          flex: 2,
          child: FittedBox(
        alignment: Alignment.center,
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
