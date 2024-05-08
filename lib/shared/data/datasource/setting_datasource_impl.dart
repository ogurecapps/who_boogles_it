import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/models/setting.dart';
import 'package:who_boogles_it/shared/data/datasource/setting_datasource.dart';

class SettingDatasourceImpl extends SettingDatasource {
  LocalDatabase db;

  SettingDatasourceImpl({required this.db});

  @override
  Future<String> getValue(String key) async {
    var setting = await db.getDb().settings.where().keyEqualTo(key).findFirst();
    if (setting == null) {
      return Setting.getDefaultValue(key);
    }
    return setting.value;
  }

  @override
  Future<void> setValue(String key, String value) async {
    await db.getDb().writeTxn(() async {
      await db.getDb().settings.put(Setting(key: key, value: value));
    });
  }
}
