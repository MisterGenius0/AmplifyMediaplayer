import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_appbar_widget.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_navbar_widget.dart';
import 'package:amplifying_mediaplayer/views/widgets/main%20UI/amplifying_sidemenu_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingScaffold extends StatefulWidget {
  const AmplifyingScaffold({super.key, required this.body});

  final Widget body;

  //TODO Have app bar input when null do default nav bar but provided use that one
  //final Widget navBar

  @override
  State<AmplifyingScaffold> createState() => _AmplifyingScaffoldState();
}

class _AmplifyingScaffoldState extends State<AmplifyingScaffold> {
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
        body: DefaultTabController(
            length: 4,
            child: AmplifyingNavbar(body: Expanded(child: widget.body))),
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
