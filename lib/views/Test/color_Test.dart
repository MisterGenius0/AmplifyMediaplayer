import 'package:flutter/material.dart';

class Colortest0 extends StatelessWidget {
  const Colortest0 ({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
    children: [
      Text("Primary", style: TextStyle(color: Theme.of(context).colorScheme.primary),),
      Container(color: Theme.of(context).colorScheme.primaryContainer, child: IconButton(color: Theme.of(context).colorScheme.primaryContainer, onPressed: (){}, icon: Icon(Icons.person, color: Theme.of(context).colorScheme.onPrimaryContainer,))),

      Text("secondary", style: TextStyle(color: Theme.of(context).colorScheme.secondary),),
      Container(color:  Theme.of(context).colorScheme.secondaryContainer,child: IconButton(color: Theme.of(context).colorScheme.secondaryContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onSecondaryContainer)),),

      Text("tertiary", style: TextStyle(color: Theme.of(context).colorScheme.tertiary),),
      Container(color:  Theme.of(context).colorScheme.tertiaryContainer,child: IconButton(color: Theme.of(context).colorScheme.tertiaryContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onTertiaryContainer)),),

      Text("background", style: TextStyle(color: Theme.of(context).colorScheme.onBackground),),
      Container(color: Theme.of(context).colorScheme.background,child: IconButton(onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onBackground)),),

      Text("error", style: TextStyle(color: Theme.of(context).colorScheme.error),),
      Container(color: Theme.of(context).colorScheme.errorContainer,child: IconButton(color: Theme.of(context).colorScheme.errorContainer, onPressed: (){}, icon: Icon(Icons.person, color:  Theme.of(context).colorScheme.onErrorContainer)),),
    ],
    );
  }
}
