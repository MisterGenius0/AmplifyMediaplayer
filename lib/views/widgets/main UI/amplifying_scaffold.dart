import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../controllers/providers/amplifying_color_provider.dart';
import 'amplifying_appbar_widget.dart';
import 'amplifying_navbar_widget.dart';
import 'amplifying_sidemenu_widget.dart';

class AmplifyingScaffold extends StatefulWidget {
  const AmplifyingScaffold({super.key, required this.body, this.useNavBar = true});

  final Widget body;
  final bool useNavBar;

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
            length: 2,
            child: AmplifyingNavbar( visible: widget.useNavBar,
                    body: Flexible(child: widget.body),
            )
        ),
        backgroundColor: context
            .watch<ColorProvider>()
            .amplifyingColor
            .backgroundDarkestColor,
      ),
      appBar: AmplifyingAppBar (
        context: context,
        leadingWidget: IconButton(
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
    );
  }
}
