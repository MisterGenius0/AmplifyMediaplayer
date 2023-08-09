import 'package:amplifying_mediaplayer/controllers/media_controller.dart';
import 'package:amplifying_mediaplayer/views/widgets/item%20grid/new_source_widget.dart';
import 'package:amplifying_mediaplayer/views/widgets/item%20grid/source_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/amplifying_color_controller.dart';
import '../widgets/amplifying_menu_widget.dart';

class SourceSubpage extends StatefulWidget {
  const SourceSubpage({super.key});

  @override
  State<SourceSubpage> createState() => _SourceSubpageState();
}



class _SourceSubpageState extends State<SourceSubpage> {

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
                preWidgetSpacer: SizedBox(),
                postWidgetSpacer: SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {},
                icon: Icons.sort,
                preWidgetSpacer: SizedBox(),
                postWidgetSpacer: SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {},
                icon: Icons.settings,
                preWidgetSpacer: SizedBox(),
                postWidgetSpacer: SizedBox()),
            AmplifyingMenuItem(
                onPressed: () => {setStates()},
                icon: Icons.refresh,
                preWidgetSpacer: SizedBox(),
                postWidgetSpacer: SizedBox()),
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
                for (var i in context.watch<MediaProvider>().sources)
                    Source(onClick: (){}, label: i.sourceName),
                NewSource(),
              ],
            ),
          )
        ],
      ),
    );
  }
}
