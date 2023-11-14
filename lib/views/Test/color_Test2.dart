import 'package:amplify/controllers/providers/amplifying_color_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Colortest2 extends StatefulWidget {
  const Colortest2 ({super.key});

  @override
  State<Colortest2> createState() => _Colortest2State();
}

class _Colortest2State extends State<Colortest2> {
  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      Text("Dom", style: TextStyle(color: context.watch<ColorProvider>().generator.dominantColor?.color),),
      Container(color: context.watch<ColorProvider>().generator.dominantColor?.color, child: IconButton(onPressed: (){}, icon: Icon(Icons.person, color: context.watch<ColorProvider>().generator.dominantColor?.color,))),

      Text("Muted", style: TextStyle(color: context.watch<ColorProvider>().generator.mutedColor?.color),),
      Container(color: context.watch<ColorProvider>().generator.darkMutedColor?.color,  child: IconButton( onPressed: (){}, icon: Icon(Icons.person, color:  context.watch<ColorProvider>().generator.lightMutedColor?.color))),

      Text("Vib", style: TextStyle(color: context.watch<ColorProvider>().generator.vibrantColor?.color),),
      Container(color: context.watch<ColorProvider>().generator.darkVibrantColor?.color, child: IconButton(onPressed: (){}, icon: Icon(Icons.person, color:  context.watch<ColorProvider>().generator.lightVibrantColor?.color)),
      )    ],
    );
  }
}
