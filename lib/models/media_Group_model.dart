import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/cupertino.dart';


class MediaGroup
{

  MediaGroup({required this.name, required this.secondaryLabel,  this.images});

  final String name;
  final List<ImageProvider>? images;
  final String secondaryLabel;

}