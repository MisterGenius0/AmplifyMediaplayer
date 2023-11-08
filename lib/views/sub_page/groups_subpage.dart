import 'package:amplify/controllers/widgets/sub_page/media_subpage_controller.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/views/widgets/item%20grid/base_Item_Grid.dart';
import 'package:amplify/views/widgets/item%20grid/media_grid_item.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';

class GroupsSubpage extends StatefulWidget {
  const GroupsSubpage({super.key});

  @override
  State<GroupsSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<GroupsSubpage> {
  late MediaDBModel mediaDBModel;
  late Future<List<MediaGroup>> groups;
  late MediaSource? source;
  List<Future<List<ImageProvider>>> images = [];

  void getPictures() async
  {

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    source = arguments['mediaSource'];

    images = [];
    for (var group in await groups)
    {
      images.add(mediaDBModel.getGroupImage(group));
    }
  }

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    source = arguments['mediaSource'];
    mediaDBModel = MediaDBModel();

    groups = mediaDBModel.getGroups(source!, source!.sourceID);
    getPictures();
  }


  @override
  Widget build(BuildContext context) {
    groups = mediaDBModel.getGroups(source!, source!.sourceID);
    BaseItemGrid baseItemGrid = BaseItemGrid();
    MediaSubpageController mediaSubpageController = MediaSubpageController();

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: groups,
              builder: (BuildContext context,
                  AsyncSnapshot<List<MediaGroup>> snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount:
                      baseItemGrid.crossAxisGridCount(context),
                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                      children: [
                        for (final (index, group) in snapshot.data!.indexed)
                          if(images.isNotEmpty)
                            FutureBuilder(
                              future: images[index],
                              builder: (BuildContext context,
                                  AsyncSnapshot<List<ImageProvider>> snapshot) {
                                if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                {
                                  return MediaGridItem(name: group.name, mainOnPress: (){mediaSubpageController.groupOnPress(context, group);}, contextMenuOnPress: (){}, subtext: "Test", images: snapshot.data,);
                                }
                                else
                                {
                                  return MediaGridItem(name: group.name, mainOnPress: (){mediaSubpageController.groupOnPress(context, group);}, contextMenuOnPress: (){}, subtext: "Test",);
                                }
                              },
                            ),
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
