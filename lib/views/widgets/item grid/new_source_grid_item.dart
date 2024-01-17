import 'package:amplify/controllers/widgets/new_source_controller.dart';
import 'package:amplify/views/widgets/item%20grid/base_grid_item.dart';
import 'package:flutter/material.dart';

class NewSourceGridItem extends StatelessWidget {
  const NewSourceGridItem({super.key});

  @override
  Widget build(BuildContext context) {
    NewSourceGridItemController newSourceController = NewSourceGridItemController();
    return BaseGridItem(title: "New Source", icon: Icons.add_circle, mainOnPress: ()=>{newSourceController.newSourceOnPressController(context)});
  }
}
