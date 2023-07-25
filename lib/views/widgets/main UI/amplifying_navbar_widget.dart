import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingNavbar extends StatelessWidget {
  const AmplifyingNavbar({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            const Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
              ),
            ),
            Flexible(
              flex: 4,
              child: TabBar(
                indicatorColor:
                    context.read<ColorProvider>().amplifyingColor.accentLighterColor,
                indicatorSize: TabBarIndicatorSize.tab,
                indicatorWeight: 5,
                unselectedLabelColor:
                    context.read<ColorProvider>().amplifyingColor.lightColor,
                unselectedLabelStyle: const TextStyle(
                  fontSize: 25,
                ),
                labelStyle: const TextStyle(fontSize: 30),
                labelColor:
                    context.read<ColorProvider>().amplifyingColor.accentLighterColor,
                tabs: const [
                  Tab(
                    text: "Sources",
                  ),
                  Tab(
                    text: "Playlists",
                  ),
                  Tab(
                    text: "Albums",
                  ),
                  Tab(
                    text: "All Music",
                  ),
                ],
              ),
            ),
            const Flexible(
              flex: 1,
              child: FractionallySizedBox(
                widthFactor: 1,
              ),
            ),
          ],
        ),
        body
      ],
    );
  }
}
