import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/controllers/widgets/source_controller.dart';
import 'package:amplify/models/Source_model.dart';
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

  @override
  Widget build(BuildContext context) {
    sourceDBModel = context.watch<MediaProvider>().sourceDBModel;
    sources = sourceDBModel.getAllSources();

    return Scaffold(
      backgroundColor:
          context.watch<ColorProvider>().amplifyingColor.backgroundDarkestColor,
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
                        for (var source in snapshot.data!)
                          Source(
                              onClick: () {
                                controller.sourceOnPress(context, source);
                              },
                              mediaSource: source),
                        MediaGridItem(name: "Test {DUMMY}", mainOnPress: (){}, contextMenuOnPress: (){}, subtext: "Test"),
                        const NewSource(),
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
