import 'package:flutter/material.dart';
import '../sub_page/source_subpage.dart';
import '../widgets/main UI/amplifying_scaffold.dart';


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
        ,Placeholder(),
      ]),
    );
  }
}


