import 'package:isar/isar.dart';
import 'package:who_boogles_it/models/localized_string.dart';

@embedded
class Answer {
  Id isarId = Isar.autoIncrement;
  int weight;
  List<LocalizedString> text;

  Answer({required this.weight, required this.text});
}
