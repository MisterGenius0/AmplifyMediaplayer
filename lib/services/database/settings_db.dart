import 'base_db.dart';

class SettingsDBModel extends BaseDBModel
{
  SettingsDBModel();

  @override
  String get dbName => "Settings";
}