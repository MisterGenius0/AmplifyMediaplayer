import 'package:amplify/models/database/base_db_model.dart';

class BlobDBModel extends baseDBModel
{
  BlobDBModel({required super.db});

 @override
  String get dbName => "Blob";

}