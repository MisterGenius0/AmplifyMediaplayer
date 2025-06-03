import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'amplifying_source_list_item.dart';
import '../common/amplifying_setting_label.dart';

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
    FileController fileController = FileController();


    return AmplifyingSettingLabel(
      leadingText: "Sources",
      haveBackground: false,
      leadingTextSuffix: " ",
      leadingTextSuffixWidgets: [
        IconButton(
          padding: const EdgeInsets.only(left: 5),
          splashRadius: 30,
          iconSize: 50,
            color: context
                .read<ColorProvider>()
                .amplifyingColor
                .accentColor,
            onPressed: ()=>{
            fileController.pickDirectory().then((value) => {
              value!= null ? files.add(value) : ""
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
