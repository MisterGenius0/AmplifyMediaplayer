import 'package:flutter/material.dart';
import 'package:amplify/views/sub_page/source_subpage.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';


class SourcePage extends StatefulWidget {
  const SourcePage({super.key});

  @override
  State<SourcePage> createState() => _SourceWidgetState();
}

class _SourceWidgetState extends State<SourcePage> {


  @override
  Widget build(BuildContext context) {
    return  const AmplifyingScaffold(
        body: SourceSubpage());
  }
}


