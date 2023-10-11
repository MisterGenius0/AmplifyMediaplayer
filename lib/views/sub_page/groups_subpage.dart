import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/views/widgets/item%20grid/media_grid_item.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class GroupsSubpage extends StatefulWidget {
  const GroupsSubpage({super.key});

  @override
  State<GroupsSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<GroupsSubpage> {
  late MediaDBModel mediaDBModel;
  Future<List<MediaGroup>>? groups;
  late MediaSource? source;
  void setStates() {
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    source = arguments['mediaSource'];
    mediaDBModel = context.watch<MediaProvider>().mediaDBModel;
    groups = mediaDBModel.getGroups(source!, source!.sourceID);

    return AmplifyingScaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          //   AmplifyingMenuItem(
          //       onPressed: () => {},
          //       icon: Icons.filter_alt,
          //       preWidgetSpacer: const SizedBox(),
          //       postWidgetSpacer: const SizedBox()),
          //   AmplifyingMenuItem(
          //       onPressed: () => {},
          //       icon: Icons.sort,
          //       preWidgetSpacer: const SizedBox(),
          //       postWidgetSpacer: const SizedBox()),
          //   AmplifyingMenuItem(
          //       onPressed: () => {},
          //       icon: Icons.settings,
          //       preWidgetSpacer: const SizedBox(),
          //       postWidgetSpacer: const SizedBox()),
          //   AmplifyingMenuItem(
          //       onPressed: () => {setStates()},
          //       icon: Icons.refresh,
          //       preWidgetSpacer: const SizedBox(),
          //       postWidgetSpacer: const SizedBox()),
          // ]),
          const Flexible(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 1,
              )),
          FutureBuilder(
              future: groups,
              builder: (context, AsyncSnapshot<List<MediaGroup>> snapshot) {
                if (snapshot.hasData) {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 800 ? 4 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 70,
                      children: [
                        for (MediaGroup item in snapshot.data ?? [])
                          Column(
                            children: [
                              Flexible(
                                  child: MediaGridItem(
                                name: item.name,
                                mainOnPress: () {},
                                contextMenuOnPress: () {},
                                subtext: "subtext",
                                images: item.images,
                              )),

                              // //TODO add code to sources and group widget insted of page
                              // if(item.images!.length >= 4)
                              // item.images!.isNotEmpty  ? Expanded(child: GridView.count(crossAxisCount:  2, children: [
                              //   Image(image:  item.images![0], fit: BoxFit.fill,),
                              //   Image(image:  item.images![1], fit: BoxFit.fill,),
                              //   Image(image:  item.images![2], fit: BoxFit.fill,),
                              //   Image(image:  item.images![3], fit: BoxFit.fill,),
                              // ],),) : Container(),
                              // if(item.images!.length < 4)
                              //   item.images!.isNotEmpty  ? Expanded(child: Image(image: (item.images![0]), fit: BoxFit.fill,)) : Container(),
                              // Text(item.name,
                              //   style: TextStyle(
                              //       color: Colors.white
                              //   ),
                              // ),
                            ],
                          ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      SpinKitRing(
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        " ERROR: ${snapshot.error}",
                        style: TextStyle(
                            color: context
                                .watch<ColorProvider>()
                                .amplifyingColor
                                .accentColor,
                            fontSize: 50),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      SpinKitRing(
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor,
                        size: 100,
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      Text(
                        "   Loading... ",
                        style: TextStyle(
                            color: context
                                .watch<ColorProvider>()
                                .amplifyingColor
                                .accentColor,
                            fontSize: 50),
                      ),
                    ],
                  );
                }
              })
        ],
      ),
    );
  }
}
