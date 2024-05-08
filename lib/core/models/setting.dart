import 'package:isar/isar.dart';

part 'setting.g.dart';

@collection
class Setting {
  Id isarId = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  String key;
  String value;

  Setting({required this.key, required this.value});

  // Default values
  static String getDefaultValue(String key) {
    return switch (key) {
      keySome => 'some_value',
      _ => '',
    };
  }

  // Keys
  static const String keySome = 'some_key';
}
