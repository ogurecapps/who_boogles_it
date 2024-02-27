import 'package:isar/isar.dart';

part 'localized_string.g.dart';

@embedded
class LocalizedString {
  String? langCode;
  String? text;

  LocalizedString({this.langCode, this.text});
}
