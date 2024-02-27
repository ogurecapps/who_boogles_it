import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/models/localized_string.dart';

part 'answer.g.dart';

@embedded
class Answer {
  byte weight;
  List<LocalizedString>? text;

  Answer({this.weight = 0, this.text});
}
