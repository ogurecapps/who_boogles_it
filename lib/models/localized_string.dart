import 'package:isar/isar.dart';

@embedded
class LocalizedString {
  Id isarId = Isar.autoIncrement;
  @Index(type: IndexType.value)
  String langCode;
  String text;

  LocalizedString({required this.langCode, required this.text});
}
