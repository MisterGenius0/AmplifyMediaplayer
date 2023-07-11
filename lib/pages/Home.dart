import 'package:flutter/material.dart';

import '../amplifying_colors.dart';
import '../widgets/amplifying_appbar.dart';
import '../widgets/amplifying_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeScreen> {
  var color = AmplifyingColor();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  void updateState ()
  {
    setState(() {
    });
  }

  @override
  void initState() {
    super.initState();

    color.updateColors(defaultColor);
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            backgroundColor: color.backgroundDarkColor,
            child: ListView(
              children: [
                MenuSection(
                  title: "Menu",
                  widgetList: [
                    MenuItem(
                        icon: Icons.queue_music,
                        text: "Music",
                        color: color,
                        onPressed: () => {}),
                    MenuItem(
                        icon: Icons.folder,
                        text: "Sources",
                        color: color,
                        onPressed: () => {}),
                    MenuItem(
                        icon: Icons.settings,
                        text: "Settings",
                        color: color,
                        onPressed: () => {}),
                  ],
                  color: color,
                ),
                MenuSection(
                  title: "Colors",
                  widgetList: [
                    MenuItem(
                        icon: Icons.reddit,
                        text: "Red",
                        color: color,
                        onPressed: ()=>{color.updateColors(Colors.red),updateState()},
                    ),
                    MenuItem(
                        icon: Icons.bluetooth,
                        text: "Blue",
                        color: color,
                        onPressed: () => {color.updateColors(Colors.blue),updateState()}),
                    MenuItem(
                        icon: Icons.account_tree_outlined,
                        text: "Green",
                        color: color,
                        onPressed: () => {color.updateColors(Colors.green),updateState()}),
                    MenuItem(
                        icon: Icons.public_rounded,
                        text: "Purple",
                        color: color,
                        onPressed: () => {color.updateColors(Colors.purple),updateState()}),
                    MenuItem(
                        icon: Icons.disabled_by_default,
                        text: "Default",
                        color: color,
                        onPressed: () => {color.updateColors(defaultColor),updateState()}),

                  ],
                  color: color,
                ),
                const SizedBox(height: 50),
              ],
            )),
        backgroundColor: color.backgroundDarkestColor,
      ),
      appBar: AmplifyingAppBar(
        color: color,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.menu, size: 40,),
            color: color.accentColor,
            onPressed: () => {
              _scaffoldKey.currentState!.isDrawerOpen
                  ? _scaffoldKey.currentState?.closeDrawer()
                  : _scaffoldKey.currentState?.openDrawer(),
            },
            tooltip: "Side Menu",
          ),
        ),
      ),
    );
  }
}


