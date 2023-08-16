import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/new_source_controller.dart';
import '../../controllers/providers/amplifying_color_provider.dart';
import '../../controllers/providers/media_provider.dart';
import '../widgets/amplifying_menu_widget.dart';
import '../widgets/item grid/new_source_widget.dart';
import '../widgets/item grid/source_widget.dart';

class GroupsSubpage extends StatefulWidget {
  const GroupsSubpage({super.key});

  @override
  State<GroupsSubpage> createState() => _SourceSubpageState();
}



class _SourceSubpageState extends State<GroupsSubpage> {

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
          const SizedBox(height: 50),
          Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            AmplifyingMenuItem(
                onPressed: () => {},
                icon: Icons.filter_alt,
                preWidgetSpacer: const SizedBox(),
                postWidgetSpacer: const SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {},
                icon: Icons.sort,
                preWidgetSpacer: const SizedBox(),
                postWidgetSpacer: const SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {},
                icon: Icons.settings,
                preWidgetSpacer: const SizedBox(),
                postWidgetSpacer: const SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {setStates()},
                icon: Icons.refresh,
                preWidgetSpacer: const SizedBox(),
                postWidgetSpacer: const SizedBox()),
          ]),
          const Flexible(
              flex: 1,
              child: FractionallySizedBox(
                heightFactor: 1,
              )),
          Flexible(
            flex: 15,
            child: GridView.count(
              crossAxisCount: 4,
              crossAxisSpacing: 12,
              mainAxisSpacing: 70,
              children: [
                for (var source in context.watch<MediaProvider>().sources)
                  Source(onClick: (){newSourceOnPressController(context, source);}, mediaSource: source),
                const NewSource(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
