import 'package:amplify/controllers/widgets/sub_page/media_subpage_controller.dart';

//TODO Remove need for this import (mediaDBModel), move to controller
import 'package:amplify/services/database/media_db.dart';

import 'package:amplify/models/media_group_model.dart';
import 'package:amplify/models/media_model.dart';
import 'package:amplify/views/widgets/item%20grid/amplifying_base_grid_item.dart';
import 'package:amplify/views/widgets/item%20grid/amplifying_grid_Seperator.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:amplify/views/widgets/item%20grid/amplifying_base_Item_Grid.dart';



class MediaSubpage extends StatefulWidget {
  const MediaSubpage({super.key});

  @override
  State<MediaSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<MediaSubpage> {
  late MediaDBModel mediaDBModel;
  late Future<List<Media>> mediasUnsorted;
  late Future<List<List<List<Map<Media, int>>>>> mediasSorted;
  late MediaGroup mediaGroup;
  List<Future<List<ImageProvider>>> images = [];
  ColorScheme sceme  = const ColorScheme.dark();

  List<String> things = ["Thing1", "Thing2", "Thing4"];
  int thingCount = 0;

  void getPictures() async
  {
    images = [];
    for (var media in await mediasUnsorted)
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

    mediasUnsorted =  mediaDBModel.getMediaFromGroup(mediaGroup);
    mediasSorted =  mediaDBModel.getMediaFromGroupSorted(mediaGroup);
    getPictures();
  }
  @override
  Widget build(BuildContext context) {
    MediaSubpageController mediaSubpageController = MediaSubpageController();

    AmplifyingBaseItemGrid baseItemGrid = AmplifyingBaseItemGrid();
    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: mediasSorted,
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
                            AmplifyingGridSeparator(icon: Icons.person, label: albums[0][0].keys.first.album!,),
                            for (final (discs) in albums)
                              ...[
                                if(albums.length > 1)
                                AmplifyingGridSeparator(icon: Icons.album, label: discs[0].keys.first.discNumber.toString(),),
                                    GridView.count(
                                      physics: const NeverScrollableScrollPhysics(),
                                      shrinkWrap: true,
                                      crossAxisCount:
                                      baseItemGrid.crossAxisGridCount(context),
                                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                                      children: [
                                              for (final (media) in discs)
                                              if(images.isNotEmpty)
                                                FutureBuilder(
                                                  future: images[media.values.first],
                                                  builder: (BuildContext context,
                                                      AsyncSnapshot<List<ImageProvider>> snapshot) {
                                                    if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                                    {
                                                      return AmplifyingBaseGridItem(subtext: media.keys.first.album,  title:  "${media.keys.first.trackNumber != null ? "${media.keys.first.trackNumber} - " : ""} ${ media.keys.first.mediaName ?? ""}", mainOnPress: (){
                                                        mediaSubpageController.mediaOnPress(clickedMedia:  media.keys.first.mediaPath, context: context, mediaGroup: mediaGroup);
                                                        }, contextMenuOnPress: (){}, images: snapshot.data,);
                                                    }
                                                    else
                                                    {
                                                      return AmplifyingBaseGridItem(subtext: media.keys.first.album, title: media.keys.first.mediaName ?? " ", mainOnPress: (){
                                                        mediaSubpageController.mediaOnPress(clickedMedia:  media.keys.first.mediaPath, context: context, mediaGroup: mediaGroup);}, contextMenuOnPress: (){});
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
