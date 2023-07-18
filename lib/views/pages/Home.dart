import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_scaffold.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeScreen> {


  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return AmplifyingScaffold(
      body: Placeholder(),
    );
  }
}


