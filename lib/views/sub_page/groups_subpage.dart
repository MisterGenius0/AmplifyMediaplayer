import 'package:amplify/controllers/widgets/sub_page/group_subpage_controller.dart';
import 'package:amplify/models/source_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/views/widgets/item%20grid/amplifying_base_Item_Grid.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';

import 'package:amplify/views/widgets/item%20grid/amplifying_base_grid_item.dart';



//TODO Remove need for this import (mediaDBModel), move to controller
import 'package:amplify/services/database/media_db.dart';
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
    AmplifyingBaseItemGrid baseItemGrid = AmplifyingBaseItemGrid();
    GroupSubpageController groupSubpageController = GroupSubpageController();

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          StreamBuilder(
              stream: Stream.fromFuture(groups),
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
                                  //New base grid item
                                  return  AmplifyingBaseGridItem(title: group.name, subtext: group.secondaryLabel,  mainOnPress: ((){groupSubpageController.groupOnPress(context, group);}), contextMenuOnPress: ((){}), images: snapshot.data,);
                                }
                                else
                                {
                                   return AmplifyingBaseGridItem(title: group.name, subtext: group.secondaryLabel, mainOnPress: ((){groupSubpageController.groupOnPress(context, group);}), contextMenuOnPress: ((){}));
                                }
                              },
                            ),
])
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
