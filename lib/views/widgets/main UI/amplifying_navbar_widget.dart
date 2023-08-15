import 'package:amplifying_mediaplayer/controllers/providers/amplifying_color_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AmplifyingNavbar extends StatelessWidget {
  const AmplifyingNavbar({super.key, required this.body, this.visible = true});

  final Widget body;
  final bool visible;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Visibility(
          visible: visible,
          child: Row(
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
                    fontSize: 20,
                  ),
                  labelStyle: const TextStyle(fontSize: 24),
                  labelColor:
                      context.read<ColorProvider>().amplifyingColor.accentLighterColor,
                  tabs: const [
                    Tab(
                      text: "Music",
                      icon: Icon(Icons.queue_music_rounded),
                      iconMargin: EdgeInsets.zero,
                    ),
                    Tab(
                      text: "Favorites",
                      icon: Icon(Icons.favorite),
                      iconMargin: EdgeInsets.zero,
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
        ),
        body
      ],
    );
  }
}
