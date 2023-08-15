import 'package:amplifying_mediaplayer/views/widgets/amplifying_source_list_item.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_setting_label.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';

import 'package:amplifying_mediaplayer/controllers/file_controller.dart';

class AmplifyingSourceList extends StatefulWidget {
  const AmplifyingSourceList({super.key, required this.initalList});

  final List<String> initalList;

  @override
  State<AmplifyingSourceList> createState() => _AmplifyingSourceListState();
}

class _AmplifyingSourceListState extends State<AmplifyingSourceList> {
  List<String> files = [];

  @override
  void initState() {
    files = widget.initalList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AmplifyingSettingLabel(
      leadingText: "Sources",
      haveBackground: false,
      leadingTextSuffix: " ",
      LeadingTextSuffixWidgets: [
        IconButton(
          padding: const EdgeInsets.only(left: 5),
          splashRadius: 30,
          iconSize: 50,
            color: context
                .read<ColorProvider>()
                .amplifyingColor
                .accentColor,
            onPressed: ()=>{
            PickDirectory().then((value) => {
              value!= null ? files.add(value ?? "NULL") : ""
              , setState(() {

            })})},
            icon: const Icon(
                Icons.add_circle,
            )
        )],
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var source in files)
          AmplifyingSourceListItem(text: source,),
        ],
      ),
    );
  }
}
