import 'dart:typed_data';
import 'dart:ui';

import 'package:amplify/models/Source_model.dart';


class MediaGroup
{

  MediaGroup({required this.name, required this.secondaryLabel, required this.mediaSource});

  final String name;
  final String secondaryLabel;
  final MediaSource mediaSource;

}