import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../amplifying_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {

    var color = AmplifyingColor();
    color.updateColors(Color.fromRGBO(57, 153, 40, 1.0));
    return  Scaffold(
      body: Column(
        children: [
          TextButton(onPressed: ()=>{Navigator.pushReplacementNamed(context, "/")}, child: Text("Hi"), style: TextButton.styleFrom(foregroundColor: color.darkestColor, backgroundColor: color.accentColor),)
        ],
      ),
      appBar: AppBar(title: Text("Home"), backgroundColor: color.lightColor,),
      backgroundColor: color.backgroundDarkColor,
    );
  }
}
