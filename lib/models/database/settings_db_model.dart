import 'package:amplify/models/database/base_db_model.dart';

class SettingsDBModel extends baseDBModel
{
  SettingsDBModel();

  @override
  String get dbName => "Settings";
}