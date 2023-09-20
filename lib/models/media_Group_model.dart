import 'package:metadata_god/metadata_god.dart';

class MediaGroup
{

  MediaGroup(this.secondaryLabel, {required this.name,  this.picture});

  final String name;
  final List<Picture>? picture ;
  final String secondaryLabel;

}