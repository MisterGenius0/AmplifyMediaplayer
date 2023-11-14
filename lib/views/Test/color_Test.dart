import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Colortest0 extends StatelessWidget {
  const Colortest0 ({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      Text("Primary", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      Container(child: IconButton(color: Theme.of(context).colorScheme.primaryContainer, onPressed: (){}, icon: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimaryContainer,)), color: Theme.of(context).colorScheme.primaryContainer),

      Text("secondary", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
      Container(child: IconButton(color: Theme.of(context).colorScheme.secondaryContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onSecondaryContainer)), color:  Theme.of(context).colorScheme.secondaryContainer,),

      Text("tertiary", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
      Container(child: IconButton(color: Theme.of(context).colorScheme.tertiaryContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onTertiaryContainer)), color:  Theme.of(context).colorScheme.tertiaryContainer,),

      Text("background", style: TextStyle(color: Theme.of(context).colorScheme.onBackground),),
      Container(child: IconButton(onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onBackground)), color: Theme.of(context).colorScheme.background,),

      Text("error", style: TextStyle(color: Theme.of(context).colorScheme.error),),
      Container(child: IconButton(color: Theme.of(context).colorScheme.errorContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onErrorContainer)), color: Theme.of(context).colorScheme.errorContainer,),
    ],
    );
  }
}
