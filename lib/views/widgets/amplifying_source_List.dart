import 'package:amplifying_mediaplayer/views/widgets/amplifying_source_list_item.dart';
import 'package:amplifying_mediaplayer/views/widgets/common/amplifying_setting_label.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controllers/amplifying_color_controller.dart';

class AmplifyingSourceList extends StatelessWidget {
  const AmplifyingSourceList({super.key});

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
            onPressed: ()=>{},
            icon: const Icon(
                Icons.add_circle,
            )
        )],
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          AmplifyingSourceListItem(text: "Test",),
        ],
      ),
    );
  }
}
