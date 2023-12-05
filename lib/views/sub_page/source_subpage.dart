
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/views/widgets/item%20grid/base_Item_Grid.dart';
import 'package:amplify/views/widgets/item%20grid/media_grid_item.dart';
import 'package:amplify/views/widgets/item%20grid/new_source_widget.dart';
import 'package:flutter/material.dart';

import 'package:amplify/controllers/widgets/sub_page/source_subpage_controller.dart';

class SourceSubpage extends StatefulWidget {
  const SourceSubpage({super.key});

  @override
  State<SourceSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<SourceSubpage> {
  SourceSubpageController controller = SourceSubpageController();
  List<Future<List<ImageProvider>>> images = [];
  BaseItemGrid baseItemGrid = BaseItemGrid();

  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies

    controller.getPictures().then((value) => images = value);
    super.didChangeDependencies();

  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FutureBuilder(
              future: controller.getAllSources(context),
              builder: (BuildContext context,
                  AsyncSnapshot<List<MediaSource>> snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount:
                      baseItemGrid.crossAxisGridCount(context),
                      crossAxisSpacing: baseItemGrid.gridCrossAxisSpacing(),
                      mainAxisSpacing: baseItemGrid.gridMainAxisSpacing(),
                      children: [
                        for (final (index, source) in snapshot.data!.indexed)...[
                          if(images.isNotEmpty) ...[
                          FutureBuilder(
                          future: images[index],
                            builder: (BuildContext context,
                                AsyncSnapshot<List<ImageProvider>> snapshot) {
                            if(snapshot.hasError)
                              {
                                Text(snapshot.error.toString());
                                return MediaGridItem(name: source.sourceName, mainOnPress: (){controller.sourceOnPress(context, source);}, contextMenuOnPress: (){controller.sourceSettingsOnPress(context, source);}, subtext: "Test");
                              }

                              if(snapshot.hasData && snapshot.data!.isNotEmpty)
                                {
                                  return MediaGridItem(name: source.sourceName, mainOnPress: (){controller.sourceOnPress(context, source);}, contextMenuOnPress: (){controller.sourceSettingsOnPress(context, source);}, subtext: "Test", images: snapshot.data,);
                                }
                              else
                                {
                                  return MediaGridItem(name: source.sourceName, mainOnPress: (){controller.sourceOnPress(context, source);}, contextMenuOnPress: (){controller.sourceSettingsOnPress(context, source);}, subtext: "Test");
                                }
                            },
                          ),
                          ],
                        ],
                        const NewSource(),
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
    );
  }
}



