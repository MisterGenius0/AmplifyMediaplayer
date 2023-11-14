import 'package:amplify/views/Test/color_Test2.dart';
import 'package:flutter/material.dart';
import 'package:amplify/views/sub_page/source_subpage.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomePage> {

  
  @override
  Widget build(BuildContext context) {
    return  const AmplifyingScaffold(
      body: SourceSubpage());
  }
}


