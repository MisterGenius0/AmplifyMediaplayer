import 'package:amplify/controllers/widgets/source_controller.dart';
import 'package:amplify/models/Source_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:amplify/views/widgets/amplifying_menu_widget.dart';

class Source extends StatefulWidget {
  const Source({super.key, required this.onClick, required this.mediaSource});

  final MediaSource mediaSource;
  final VoidCallback? onClick;

  @override
  State<Source> createState() => _SourceState();
}

class _SourceState extends State<Source> {

  @override
  Widget build(BuildContext context) {
    widget.mediaSource.countNotifier.addListener(() {setState(() {
    });});
    SourceController controller = SourceController();
    return Column(
      children: [
        Expanded(
          flex: 20,
          child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: BorderSide(
                      width: 5,
                      style: BorderStyle.solid,
                      color: context.watch<ColorProvider>().amplifyingColor.accentLighterColor
                  )
              ),
              color: context
                  .watch<ColorProvider>()
                  .amplifyingColor
                  .backgroundDarkerColor,
              child: FittedBox(
                  fit: BoxFit.fill,
                  child: IconButton(
                    onPressed: ()=>{controller.sourceOnPress(context, widget.mediaSource)},
                    icon: Icon(Icons.library_music,
                        color: context
                            .watch<ColorProvider>()
                            .amplifyingColor
                            .accentColor),
                  ))),
        ),
        Center(
          child: AmplifyingMenuItem(
              onPressed: () =>{controller.sourceSettingsOnPress(context, widget.mediaSource)},
              icon: Icons.settings,
              preWidgetSpacer: const SizedBox(),
              postWidgetSpacer: const SizedBox()),
        ),
        if((widget.mediaSource.currentCount / widget.mediaSource.totalcount ) < 1)
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: LinearProgressIndicator(
              color: context.watch<ColorProvider>().amplifyingColor.accentColor,
              value:  widget.mediaSource.currentCount / widget.mediaSource.totalcount,
              minHeight: 10,
              backgroundColor: context.watch<ColorProvider>().amplifyingColor.backgroundDarkColor,
            ),
          ),

        if((widget.mediaSource.currentCount / widget.mediaSource.totalcount ) < 1)
          Text("Loading... ${((widget.mediaSource.currentCount / widget.mediaSource.totalcount) *100).round()}%",
              style: TextStyle(color:   context.watch<ColorProvider>().amplifyingColor.whiteColor)),

        if((widget.mediaSource.currentCount / widget.mediaSource.totalcount ) < 1)
          SizedBox(height: 50,),


        Expanded(
          flex: 1,
          child: FittedBox(
            child: Text(
              widget.mediaSource.sourceName,
              style: TextStyle(
                  color: context
                      .watch<ColorProvider>()
                      .amplifyingColor
                      .whiteColor),
            ),
          ),
        ),
      ],
    );
  }
}
