import 'package:flutter/material.dart';
import 'dart:core';

import 'package:provider/provider.dart';

import 'package:amplifying_mediaplayer/controllers/amplifying_color_controller.dart';

import 'amplifying_setting_label.dart';

class AmplifyingDropdown extends StatefulWidget {
  const AmplifyingDropdown({super.key, required this.items, this.leadingText, this.description, this.defaultSelected});
  final  List<String>  items;

  /// this needs to be one of the items in the list
  final String? defaultSelected;
  final String? leadingText;
  final String? description;

  @override
  State<AmplifyingDropdown> createState() => _AmplifyingDropdownState();
}

class _AmplifyingDropdownState extends State<AmplifyingDropdown> {
  String?  dropdownValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dropdownValue = widget.defaultSelected;
  }

  @override
  Widget build(BuildContext context) {

    return AmplifyingSettingLabel(
      leadingText: widget.leadingText,
      description: widget.description,
      child: Padding(
        padding: const EdgeInsets.only(left: 12.0),
        child: DropdownButton<String>(
          isExpanded: true,
          borderRadius: BorderRadius.circular(2,),
          value: dropdownValue,
          style: TextStyle(
            fontSize: 20,
            color: context
                .read<ColorProvider>()
                .amplifyingColor
                .whiteColor,
          ),
          iconSize: 50,
          icon: Icon(
              Icons.keyboard_arrow_down_outlined,
            color:  context.read<ColorProvider>().amplifyingColor.accentLighterColor,
          ),
          focusColor: context
              .read<ColorProvider>().
          amplifyingColor.
          backgroundDarkestColor,
          dropdownColor: context
              .read<ColorProvider>()
              .amplifyingColor
              .darkestColor,
          elevation: 5,

          underline: Container(
            height: 0,
            color: context
                .read<ColorProvider>()
                .amplifyingColor
                .darkColor,
          ),
          onChanged: (String? value) {
            // This is called when the user selects an item.
            setState(() {
               dropdownValue = value!;
            });
          },
          items: widget.items.map<DropdownMenuItem<String>>((String item) {
            return DropdownMenuItem<String>(
              value: item,
              child: Text(
                  item,
                style: TextStyle(
                  color:  context
                      .read<ColorProvider>()
                      .amplifyingColor
                      .whiteColor,
                ),
              ),
          );
          }).toList(),
        ),
      ),
    );
}
}
