import 'package:flutter/cupertino.dart';

class AmplifyingGridItemImage extends StatelessWidget {
  const AmplifyingGridItemImage({super.key, this.images});

  /// The images used for the grid item
  /// Multiple images will be in a grid pattern, picks up to 4 randomly
  final List<ImageProvider>? images;

  /// Will the square  be full? if yes, the square will never show partial (2 and 3 images only)
  /// will only fill the square if there are more then 4 images,
  /// if there are less then 4 images it will pick one.
  final bool fillSquare = false;

  @override
  Widget build(BuildContext context) {
    return images != null && images!.isNotEmpty
        ? images!.length > 1
            ? GridView.count(
      shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                children: [
                  Image(image: images![0], fit: BoxFit.fill),
                  if (images != null &&
                      images!.length >= 2 &&
                      fillSquare == false)
                    Image(
                      image: images![1],
                      fit: BoxFit.fill,
                    ),
                  if (images != null &&
                      images!.length >= 3 &&
                      fillSquare == false)
                    Image(image: images![2], fit: BoxFit.fill),
                  if (images != null &&
                      images!.length >= 4 &&
                      fillSquare == false)
                    Image(image: images![3], fit: BoxFit.fill),
                  // Image(image:  widget.images![3], fit: BoxFit.fill,),
                ],
              )
            : Column(
                children: [
                  Expanded(
                      child: Image(
                          fit: BoxFit.fill,
                          filterQuality: FilterQuality.high,
                          isAntiAlias: true,
                          image: images![0])),
                ],
              )
        : Container();
  }
}
