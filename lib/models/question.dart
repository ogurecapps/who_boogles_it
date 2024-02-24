import 'package:isar/isar.dart';
import 'package:who_boogles_it/models/answer.dart';
import 'package:who_boogles_it/models/localized_string.dart';

@collection
class Question {
  Id isarId = Isar.autoIncrement;
  List<LocalizedString> text;
  List<Answer> rightAnswers; // Fixed size collection
  List<LocalizedString> wrongAnswers; // Need limit
  DateTime? played;

  Question({required this.text, required this.rightAnswers, required this.wrongAnswers});
}
