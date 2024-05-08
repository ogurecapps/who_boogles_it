import 'package:who_boogles_it/shared/data/datasource/setting_datasource.dart';
import 'package:who_boogles_it/shared/domain/repositories/setting_repository.dart';

class SettingRepositoryImpl implements SettingRepository {
  SettingDatasource datasource;

  SettingRepositoryImpl({required this.datasource});

  @override
  Future<String> getValue(String key) {
    return datasource.getValue(key);
  }

  @override
  Future<void> setValue(String key, String value) {
    return datasource.setValue(key, value);
  }
}
