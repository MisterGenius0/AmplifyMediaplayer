import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/material.dart';

import '../../models/amplifying_color_models.dart';
import '../widgets/amplifying_appbar_widget.dart';
import '../widgets/amplifying_sidemenu_Widget.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            backgroundColor: context.watch<ColorProvider>().amplifyingColor.darkestColor,
            child: AmpflifyingSideMenu()),
        backgroundColor: context.watch<ColorProvider>().amplifyingColor.backgroundDarkestColor,
      ),
      appBar: AmplifyingAppBar(
        context: context,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(Icons.menu, size: 40,),
            color: context.watch<ColorProvider>().amplifyingColor.accentColor,
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


