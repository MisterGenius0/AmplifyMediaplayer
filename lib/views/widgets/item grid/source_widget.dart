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


  ///TODO fix this notifer not running when count is changed!!!!!!!!
  @override
  void initState() {
    super.initState();
    print("object");
    widget.mediaSource.countNotifier.addListener(() {print("Testsetsefeafeafaefafeaefaefaeft");});
    // TODO: implement initState

  }

  void setStates()
  {
    ;
    setState(() {


    });
  }

  @override
  Widget build(BuildContext context) {
    SourceController controller = SourceController();

    return Column(
      children: [
        Expanded(
          flex: 4,
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
                    icon: Icon(Icons.add_circle,
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
        if(widget.mediaSource.totalcount > 0)
        LinearProgressIndicator(
            value:  widget.mediaSource.currentCount / widget.mediaSource.totalcount,
        ),
        if(widget.mediaSource.totalcount > 0)
        Text("${widget.mediaSource.currentCount / widget.mediaSource.totalcount}}"),

        TextButton(onPressed: (){setState(() {

        });}, child: Text("Test"))
      ],
    );
  }
}
