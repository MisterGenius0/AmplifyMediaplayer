import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:amplifying_mediaplayer/views/widgets/item%20grid/new_item.dart';
import 'package:amplifying_mediaplayer/controllers/new_source_controller.dart';

class NewSource extends StatelessWidget {
  const NewSource({super.key});

  @override
  Widget build(BuildContext context) {
    return NewItem(label: "New Source", onClick: ()=>{newSourceOnPressController(context)});
  }
}
