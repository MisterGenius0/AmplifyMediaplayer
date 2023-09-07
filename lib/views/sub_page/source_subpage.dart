import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/controllers/providers/media_provider.dart';
import 'package:amplify/controllers/widgets/source_controller.dart';
import 'package:amplify/views/widgets/item%20grid/new_source_widget.dart';
import 'package:amplify/views/widgets/item%20grid/source_widget.dart';

class SourceSubpage extends StatefulWidget {
  const SourceSubpage({super.key});

  @override
  State<SourceSubpage> createState() => _SourceSubpageState();
}

class _SourceSubpageState extends State<SourceSubpage> {

  SourceController controller = SourceController();

  void setStates()
  {
    setState(() {

    });
  }


  @override
  Widget build(BuildContext context) {
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
          Flexible(
            flex: 15,
            child: GridView.count(
              crossAxisCount: MediaQuery.of(context).size > Size(480, 480) ? 4 : 2,
              crossAxisSpacing: 12,
              mainAxisSpacing: 70,
              children: [
                for (var source in context.watch<MediaProvider>().sourceDBModel.getAllSources())
                    Source(onClick: (){controller.sourceOnPress(context, source);}, mediaSource: source),
                const NewSource(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
