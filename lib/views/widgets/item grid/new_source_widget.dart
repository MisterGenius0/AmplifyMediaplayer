import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/new_source_controller.dart';
import 'new_item.dart';

class NewSource extends StatelessWidget {
  const NewSource({super.key});

  @override
  Widget build(BuildContext context) {
    return NewItem(label: "New Source", onClick: ()=>{newSourceOnPressController(context)});
  }
}
