import 'package:amplifying_mediaplayer/views/pages/loading_page.dart';
import 'package:amplifying_mediaplayer/views/sub_page/sources_subpage.dart';
import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeScreen> {

  
  @override
  Widget build(BuildContext context) {
    return const AmplifyingScaffold(
      body: TabBarView(children: [SourcesSubPage(),Placeholder(),Placeholder(),Placeholder()]),
    );
  }
}


