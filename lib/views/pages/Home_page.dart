import 'package:amplifying_mediaplayer/views/pages/Settings/source_settings_Page.dart';
import 'package:amplifying_mediaplayer/views/widgets/item%20grid/new_source_widget.dart';
import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';

import '../sub_page/source_subpage.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
    return const AmplifyingScaffold(
      body: TabBarView(children: [
        SourceSubpage()
        ,Placeholder()
        ,Placeholder()
        ,Placeholder()
      ]),
    );
  }
}


