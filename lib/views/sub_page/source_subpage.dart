import 'dart:isolate';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/controllers/widgets/source_controller.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/database/source_db_model.dart';
import 'package:amplify/views/widgets/item%20grid/media_grid_item.dart';
import 'package:amplify/views/widgets/item%20grid/new_source_widget.dart';
import 'package:amplify/views/widgets/item%20grid/source_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class SourceSubpage extends StatefulWidget {
  const SourceSubpage({super.key});

  @override
  State<SourceSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<SourceSubpage> {
  SourceController controller = SourceController();

  late Future<List<MediaSource>> sources;
  late SourceDBModel sourceDBModel;
  late List<Future<List<ImageProvider>>> images = [];

@override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  void getPictures() async
  {
    images = [];
    List<MediaSource> sources = await sourceDBModel.getAllSources();


    for (var source in sources)
      {
        images.add(sourceDBModel.getSourceImages(source.sourceID));
      }
  }

  @override
  Widget build(BuildContext context) {
    sourceDBModel = context.watch<MediaProvider>().sourceDBModel;
    sources = sourceDBModel.getAllSources();
  getPictures();

    MediaDBModel mediaDBModel = context.watch<MediaProvider>().mediaDBModel;
   // groups = (source!, source!.sourceID);

    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Flexible(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 1,
              )),
          FutureBuilder(
              future: sources,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MediaSource>> snapshot) {


                if (snapshot.hasData) {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 800 ? 4 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 70,
                      children: [
                        if(images.isNotEmpty)
                        for (final (index, source) in snapshot.data!.indexed)
                          FutureBuilder(
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ImageProvider>> snapshot) {

                              if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                {
                                  return MediaGridItem(name: source.sourceName, mainOnPress: (){controller.sourceOnPress(context, source);}, contextMenuOnPress: (){controller.sourceSettingsOnPress(context, source);;}, subtext: "Test", images: snapshot.data,);
                                }
                              else
                                {
                                  return MediaGridItem(name: source.sourceName, mainOnPress: (){controller.sourceOnPress(context, source);}, contextMenuOnPress: (){controller.sourceSettingsOnPress(context, source);;}, subtext: "Test");
                                }
                            }, future: images[index],
                          ),
                        const NewSource(),
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.hasError) {
                  // return Flexible(
                  //   child: Column(
                  //     mainAxisAlignment: MainAxisAlignment.center,
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: [
                  //       const Flexible(
                  //         child: SizedBox(
                  //           height: 40,
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: SpinKitRing(
                  //           color: context
                  //               .watch<ColorProvider>()
                  //               .amplifyingColor
                  //               .accentColor,
                  //           size: 100,
                  //         ),
                  //       ),
                  //       const Flexible(
                  //         child: SizedBox(
                  //           height: 50,
                  //         ),
                  //       ),
                  //       Flexible(
                  //         child: Text(
                  //           " ERROR: ${snapshot.error}",
                  //           style: TextStyle(
                  //               color: context
                  //                   .watch<ColorProvider>()
                  //                   .amplifyingColor
                  //                   .accentColor,
                  //               fontSize: 50),
                  //         ),
                  //       ),
                  //     ],
                  //   ),
                  // );
                }
                return Container();
                // else {
                //   return Flexible(
                //     child: Column(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       children: [
                //         const Flexible(
                //           child: SizedBox(
                //             height: 40,
                //           ),
                //         ),
                //         Flexible(
                //           child: SpinKitRing(
                //             color: context
                //                 .watch<ColorProvider>()
                //                 .amplifyingColor
                //                 .accentColor,
                //             size: 100,
                //           ),
                //         ),
                //         const Flexible(
                //           child: SizedBox(
                //             height: 50,
                //           ),
                //         ),
                //         Flexible(
                //           child: Text(
                //             "   Loading... ",
                //             style: TextStyle(
                //                 color: context
                //                     .watch<ColorProvider>()
                //                     .amplifyingColor
                //                     .accentColor,
                //                 fontSize: 50),
                //           ),
                //         ),
                //       ],
                //     ),
                //   );
                // }
              })
        ],
    );
  }
}


