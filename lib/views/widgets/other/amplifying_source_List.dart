import 'package:amplify/controllers/widgets/other/amplifying_source_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplify/controllers/file_controller.dart';
import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'amplifying_source_list_item.dart';
import '../common/amplifying_setting_label.dart';

enum SourceFileType
{
  directory,
  file,
}

class AmplifyingSourceList extends StatefulWidget {
  const AmplifyingSourceList({super.key, this.sourceFileType = SourceFileType.directory, this.label = "Sources" , required this.initalList, });

  final List<String> initalList;
  final SourceFileType sourceFileType;
  final String label;

  @override
  State<AmplifyingSourceList> createState() => _AmplifyingSourceListState();
}

class _AmplifyingSourceListState extends State<AmplifyingSourceList> {
  List<String> files = [];

  void removeListItem(int index)
  {
    setState(() {
     files.removeAt(index);
    });
  }

  @override
  void initState() {
    files = widget.initalList;

    print(files);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    FileController fileController = FileController();
    AmplifyingSourceListController sourceListController = AmplifyingSourceListController();

    return AmplifyingSettingLabel(
      leadingText: widget.label,
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
            setState(() {
              sourceListController.onPressAddSource(widget.sourceFileType).then((value)=>{
                for (var file in value )
                  {
                    if(files != null)
                      {
                        files.add(file!),
                        setState(() {

                        }),
                      }
                  }
              });

                  //fileController.pickDirectory().then((value) => {
              //               value!= null ? files.add(value) : ""
              //               , setState(() {
              //
              //             })})},/
            }),
            },
            icon: const Icon(
                Icons.add_circle,
            )
        )],
      child:  Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          for (var source in files)
          source != "" ? AmplifyingSourceListItem(text: source) : Container(),
        ],
      ),
    );
  }
}
