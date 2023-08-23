import 'package:amplify/controllers/widgets/new_source_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'new_item.dart';

class NewSource extends StatelessWidget {
  const NewSource({super.key});

  @override
  Widget build(BuildContext context) {
    NewSourceController newSourceController = NewSourceController();
    return NewItem(label: "New Source", onClick: ()=>{newSourceController.newSourceOnPressController(context)});
  }
}
