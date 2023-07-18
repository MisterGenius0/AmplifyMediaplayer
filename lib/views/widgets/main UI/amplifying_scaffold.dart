import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_appbar_widget.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_sidemenu_Widget.dart';

class AmplifyingScaffold extends StatefulWidget {
  const AmplifyingScaffold({super.key, required this.body});
  final Widget body;


  @override
  State<AmplifyingScaffold> createState() => _AmplifyingScaffoldState(body: body);
}

class _AmplifyingScaffoldState extends State<AmplifyingScaffold> {
_AmplifyingScaffoldState({required this.body}) {}

 Widget body;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Scaffold(
        key: _scaffoldKey,
        drawer: Drawer(
            backgroundColor:
                context.watch<ColorProvider>().amplifyingColor.darkestColor,
            child: const AmplifyingSideMenu()),
        body: body ,
        backgroundColor: context
            .watch<ColorProvider>()
            .amplifyingColor
            .backgroundDarkestColor,
      ),
      appBar: AmplifyingAppBar(
        context: context,
        leading: Padding(
          padding: const EdgeInsets.only(left: 8.0),
          child: IconButton(
            icon: const Icon(
              Icons.menu,
              size: 40,
            ),
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
