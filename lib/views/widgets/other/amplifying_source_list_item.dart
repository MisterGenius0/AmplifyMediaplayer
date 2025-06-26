import 'package:amplify/controllers/source_settings_controller.dart';
import 'package:amplify/models/source_model.dart';
import 'package:amplify/views/widgets/other/amplifying_source_List.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

import 'package:amplify/controllers/providers/amplifying_color_provider.dart';

class AmplifyingSourceListItem extends StatefulWidget {
  final String text;
  const AmplifyingSourceListItem({super.key, this.text = "NO TEXT INPUT"});

  @override
  State<AmplifyingSourceListItem> createState() => _AmplifyingSourceListItemState();
}

class _AmplifyingSourceListItemState extends State<AmplifyingSourceListItem> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    SourceSettingsController settingsController = SourceSettingsController();
    return  Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Container(
        color: context
            .read<ColorProvider>()
            .amplifyingColor
            .backgroundDarkColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                  child: Text(
                      widget.text,
                    style: TextStyle(
                      color: context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .whiteColor,
                      fontSize: 30
                    ),
                  )),

              Flexible(
                  child: MaterialButton(
                    height: 50,
                    shape: const CircleBorder(),
                    onPressed: () => {
                      context.findAncestorStateOfType<State<AmplifyingSourceList>>()?.setState(() {
                        context.findAncestorStateOfType<State<AmplifyingSourceList>>()?.widget.initalList.remove(widget.text);
                      }),
                      setState(() {
                      }),
                    },
                    child: Icon(
                      Icons.remove_circle, size: 40,
                      color: context
                          .read<ColorProvider>()
                          .amplifyingColor
                          .accentColor,
                    ),
                  ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
