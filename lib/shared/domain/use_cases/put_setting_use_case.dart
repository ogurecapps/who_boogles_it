import 'package:who_boogles_it/shared/domain/repositories/setting_repository.dart';

class PutSettingUseCase {
  final SettingRepository repository;

  PutSettingUseCase({required this.repository});

  Future<void> execute(String key, String value) {
    return repository.setValue(key, value);
  }
}
