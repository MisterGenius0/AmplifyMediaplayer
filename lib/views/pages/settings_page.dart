import 'package:flutter/material.dart';
import 'package:amplify/views/widgets/main%20UI/amplifying_scaffold.dart';


class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsWidgetState();
}

class _SettingsWidgetState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    return  const AmplifyingScaffold(
        body: Placeholder());
  }
}


