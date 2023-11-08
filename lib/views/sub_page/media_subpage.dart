  import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

import '../widgets/item grid/base_Item_Grid.dart';
import '../widgets/item grid/media_grid_item.dart';

class MediaSubpage extends StatefulWidget {
  const MediaSubpage({super.key});

  @override
  State<MediaSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<MediaSubpage> {
  late MediaDBModel mediaDBModel;
  late Future<List<Media>> media;
  late MediaGroup mediaGroup;
  List<Future<List<ImageProvider>>> images = [];

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    print(arguments['mediaGroups']);
    mediaGroup = arguments['mediaGroups'];

    print(mediaGroup);
    mediaDBModel = MediaDBModel();

    media =  mediaDBModel.getMediaFromGroup(mediaGroup);

    // media = mediaDBModel.getMediaFromGroup(mediaGroup);
  }

  @override
  Widget build(BuildContext context) {
    AudioPlayer player = AudioPlayer();
    // groups = mediaDBModel.getGroups(mediaGroup!, mediaGroup!.sourceID);
    BaseItemGrid baseItemGrid = BaseItemGrid();

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: media,
              builder: (BuildContext context,
                  AsyncSnapshot<List<Media>> snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount:
                      baseItemGrid.crossAxisGridCount(context),
                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                      children: [
                        for (final (index, media) in snapshot.data!.indexed)
                  MediaGridItem(name: media.mediaName ?? "null", mainOnPress: (){player.play(DeviceFileSource(media.mediaPath.path));}, contextMenuOnPress: (){}, subtext: "Test"),
                          // if(images.isNotEmpty)
                          //   FutureBuilder(
                          //     future: images[index],
                          //     builder: (BuildContext context,
                          //         AsyncSnapshot<List<ImageProvider>> snapshot) {
                          //       if(snapshot.hasData && snapshot.data!.isNotEmpty)
                          //       {
                          //         return MediaGridItem(name: group.name, mainOnPress: (){}, contextMenuOnPress: (){}, subtext: "Test", images: snapshot.data,);
                          //       }
                          //       else
                          //       {
                          //         return MediaGridItem(name: group.name, mainOnPress: (){}, contextMenuOnPress: (){}, subtext: "Test",);
                          //       }
                          //     },
                          //   ),
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
