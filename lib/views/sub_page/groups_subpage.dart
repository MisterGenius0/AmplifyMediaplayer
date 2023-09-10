import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupsSubpage extends StatefulWidget {
  const GroupsSubpage({super.key});

  @override
  State<GroupsSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<GroupsSubpage> {
  late Future<List<String>?> groups;

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

  Future<void> getGroups(MediaSource source)
  async {
    groups =  source.getGroups();
  }
  @override
  Widget build(BuildContext context) {

    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;
    late MediaSource? source;
  source = arguments['mediaSource'];
    getGroups(source!);


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
              if(snapshot.connectionState == ConnectionState.done)
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
                        for (var item in snapshot.data ?? [])
                          Text(item,
                            style: TextStyle(
                                color: Colors.white
                            ),
                          ),
                      ],
                    ),
                  );
                }
              else
                {
                  return Text("Loading...");
                }
            }
          )
        ],
      ),
    );
  }
}
