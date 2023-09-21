import 'dart:typed_data';


class MediaGroup
{

  MediaGroup({required this.name, required this.secondaryLabel,  this.pictures});

  final String name;
  final List<Uint8List>? pictures ;
  final String secondaryLabel;

}