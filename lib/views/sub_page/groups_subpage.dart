import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/models/database/media_db_model.dart';
import 'package:amplify/models/media_Group_model.dart';
import 'package:amplify/models/media_Model.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/models/database/source_db_model.dart';

class GroupsSubpage extends StatefulWidget {
  const GroupsSubpage({super.key});

  @override
  State<GroupsSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<GroupsSubpage> {
  late Future<List<Media>> sources;
  late MediaDBModel mediaDBModel;
  Future<List<MediaGroup>>? groups;
  void setStates()
  {
    setState(() {

    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    late MediaSource? source;
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    source = arguments['mediaSource'];
    mediaDBModel = context.watch<MediaProvider>().mediaDBModel;
    mediaDBModel.getGroups(source!, source.sourceID);



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
            builder: (context, snapshot) {
              if(snapshot == ConnectionState.done)
                {
                  return Flexible(
                    flex: 15,
                    child: GridView.count(
                      crossAxisCount: MediaQuery
                          .of(context)
                          .size > Size(480, 480) ? 4 : 2,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 70,
                      children: [
                        for (MediaGroup item in snapshot.data ?? [])
                          ListView(
                            children: [
                              //item.picture != null ? Image(image: Image.memory(item.picture![0].data).image) : Container(),
                              Text(item.name,
                                style: TextStyle(
                                    color: Colors.white
                                ),
                              ),
                            ],
                          ),
                      ],
                    ),
                  );
                }
              else
                {
                  print("loading");
                  return Text("Loading...");

                }
            }
          )
        ],
      ),
    );
  }
}
