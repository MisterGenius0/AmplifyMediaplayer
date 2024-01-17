import 'package:flutter/cupertino.dart';

class GridItemImage extends StatelessWidget {
  const GridItemImage({super.key, this.images});

  final List<ImageProvider>? images;
  final bool fillSquare = false;

  @override
  Widget build(BuildContext context) {
    return  images != null && images!.isNotEmpty  ? images!.length >1 ?  Padding(
      padding: const EdgeInsets.fromLTRB(.0, 9,0,0),
      child: GridView.count(physics: const NeverScrollableScrollPhysics(), crossAxisCount:  2, children: [
        Image(image: images![0], fit: BoxFit.fill),
        if(images != null && images!.length >= 2 && fillSquare == false)
          Image(image: images![1], fit: BoxFit.fill,),
        if(images != null && images!.length >= 3 && fillSquare == false)
          Image(image:  images![2], fit: BoxFit.fill),
        if(images != null && images!.length >= 4 && fillSquare == false)
          Image(image:  images![3], fit: BoxFit.fill),
        // Image(image:  widget.images![3], fit: BoxFit.fill,),
      ],),
    ) :  ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(.0, 9,0,0),
          child: Image( fit: BoxFit.fill, filterQuality: FilterQuality.high, isAntiAlias:  true, image: images![0]),
        ),
      ],
    ) : Container();
  }
}
