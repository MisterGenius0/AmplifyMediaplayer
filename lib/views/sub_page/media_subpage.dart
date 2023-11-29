  import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:amplify/views/widgets/item%20grid/grid_Seperator.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:provider/provider.dart';

import '../widgets/item grid/base_Item_Grid.dart';
import '../widgets/item grid/media_grid_item.dart';

class MediaSubpage extends StatefulWidget {
  const MediaSubpage({super.key});

  @override
  State<MediaSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<MediaSubpage> {
  late MediaDBModel mediaDBModel;
  late Future<List<Media>> medias;
  late Future<List<List<List<Map<Media, int>>>>> medias2;
  late MediaGroup mediaGroup;
  List<Future<List<ImageProvider>>> images = [];
  ColorScheme sceme  = ColorScheme.dark();

  List<String> things = ["Thing1", "Thing2", "Thing4"];
  int Thingcount = 0;

  void getPictures() async
  {
    images = [];
    for (var media in await medias)
    {
      images.add(mediaDBModel.getMediaImages(media));
    }
  }


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    mediaGroup = arguments['mediaGroups'];
    mediaDBModel = MediaDBModel();

    medias =  mediaDBModel.getMediaFromGroup(mediaGroup);
    medias2 =  mediaDBModel.getMediaFromGroupSorted(mediaGroup);
    getPictures();
  }
  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    BaseItemGrid baseItemGrid = BaseItemGrid();

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // FutureBuilder(
          //     future: medias,
          //     builder: (BuildContext context,
          //         AsyncSnapshot<List<Media>> snapshot) {
          //       if (snapshot.data != null) {
          //         return Flexible(
          //           flex: 15,
          //           child: ListView(
          //           children: [
          //             GridSeparator(icon: Icons.album),
          //           GridView.count(
          //             shrinkWrap: true,
          //             crossAxisCount:
          //             baseItemGrid.crossAxisGridCount(context),
          //             crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
          //             mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
          //             children: [
          //               for (final (index, media) in snapshot.data!.indexed)
          //                 if(images.isNotEmpty)
          //                   FutureBuilder(
          //                     future: images[index],
          //                     builder: (BuildContext context,
          //                         AsyncSnapshot<List<ImageProvider>> snapshot) {
          //                       if(snapshot.hasData && snapshot.data!.isNotEmpty)
          //                       {
          //                         return MediaGridItem(name:  "${media.trackNumber != null ? "${media.trackNumber} - " : ""} ${ media.mediaName ?? ""}", mainOnPress: (){
          //                           player.play(DeviceFileSource(media.mediaPath.path));
          //                           PaletteGenerator.fromImageProvider(snapshot.data![0]).then((value){
          //                             context.read<ColorProvider>().updateWithPaletteGenerator(value);
          //                           });
          //                           }, contextMenuOnPress: (){}, images: snapshot.data, subtext: "",);
          //                       }
          //                       else
          //                       {
          //                         return MediaGridItem(name: media.mediaName ?? " ", mainOnPress: (){
          //                           player.play(DeviceFileSource(media.mediaPath.path));}, contextMenuOnPress: (){}, subtext: "Test");
          //                       }
          //                     },
          //       )],
          //                   ),
          //             ],
          //           ),
          //         );
          //       } else if (snapshot.hasData && snapshot.hasError) {
          //         return baseItemGrid.gridError(context, snapshot.error);
          //       }
          //       else {
          //         return baseItemGrid.gridLoading(context);
          //       }
          //     }),
          FutureBuilder(
              future: medias2,
              builder: (BuildContext context,
                  AsyncSnapshot<List<List<List<Map<Media, int>>>>> snapshot) {
                //int index = 0;
                if (snapshot.data != null) {
                  return Flexible(
                    flex: 15,
                    child: ListView(
                      children: [
                        for (final (albums) in snapshot.data!)
                          ...[
                            if(snapshot.data!.length > 2)
                            GridSeparator(icon: Icons.person, label: albums[0][0].keys.first.album!,),
                            for (final (discs) in albums)
                              ...[
                                if(albums.length > 1)
                                GridSeparator(icon: Icons.album, label: discs[0].keys.first.discNumber.toString(),),
                                    GridView.count(
                                      shrinkWrap: true,
                                      crossAxisCount:
                                      baseItemGrid.crossAxisGridCount(context),
                                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                                      children: [
                                              for (final (index, media) in discs.indexed)
                                              if(images.isNotEmpty)
                                                FutureBuilder(
                                                  future: images[media.values.first],
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<List<ImageProvider>> snapshot) {
                                                    if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                                    {
                                                      return MediaGridItem(name:  "${media.keys.first.trackNumber != null ? "${media.keys.first.trackNumber} - " : ""} ${ media.keys.first.mediaName ?? ""}", mainOnPress: (){
                                                        player.play(DeviceFileSource(media.keys.first.mediaPath.path));
                                                        PaletteGenerator.fromImageProvider(snapshot.data![0]).then((value){
                                                          context.read<ColorProvider>().updateWithPaletteGenerator(value);
                                                        });
                                                      }, contextMenuOnPress: (){}, images: snapshot.data, subtext: "",);
                                                    }
                                                    else
                                                    {
                                                      return MediaGridItem(name: media.keys.first.mediaName ?? " ", mainOnPress: (){
                                                        player.play(DeviceFileSource(media.keys.first.mediaPath.path));}, contextMenuOnPress: (){}, subtext: "Test");
                                                    }
                                                  },
                                                )],
                                    ),
                              ],
                          ],
                      ],
                    ),
                  );
                } else if (snapshot.hasData && snapshot.hasError) {
                  return baseItemGrid.gridError(context, snapshot.error);
                }
                else {
                  return baseItemGrid.gridLoading(context);
                }
              })
        ],
      ),
    );
  }
}
