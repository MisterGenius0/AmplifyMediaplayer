import 'dart:typed_data';
import 'dart:ui';

import 'package:amplify/models/Source_model.dart';
import 'package:amplify/views/widgets/item%20grid/NewItems/source_widget.dart';
import 'package:flutter/cupertino.dart';


class MediaGroup
{

  MediaGroup({required this.name, required this.secondaryLabel, required this.mediaSource});

  final String name;
  final String secondaryLabel;
  final MediaSource mediaSource;

}