import 'package:who_boogles_it/shared/domain/repositories/setting_repository.dart';

class GetSettingUseCase {
  final SettingRepository repository;

  GetSettingUseCase({required this.repository});

  Future<String> execute(String key) {
    return repository.getValue(key);
  }
}
