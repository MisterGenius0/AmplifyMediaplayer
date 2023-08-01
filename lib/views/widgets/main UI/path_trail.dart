import 'package:flutter/material.dart';

class PathTrail extends StatelessWidget {
  const PathTrail({super.key, required this.body});

  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Column(
        children: [
          const Padding(padding: EdgeInsets.symmetric(vertical: 25)),
          const Text("Trail... All Music - Settings - X", style: TextStyle(color: Colors.white, fontSize: 25),),
          Flexible(child: body),
        ],
      ),
    );
  }
}
