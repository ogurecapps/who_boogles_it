import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/models/answer.dart';
import 'package:who_boogles_it/core/models/localized_string.dart';

part 'question.g.dart';

@collection
class Question {
  Id isarId = Isar.autoIncrement;
  List<LocalizedString> text;
  List<Answer> rightAnswers; // Fixed size collection
  List<LocalizedString> wrongAnswers; // Need limit
  @Index()
  DateTime? lastPlayed;

  Question({required this.text, required this.rightAnswers, required this.wrongAnswers});
}
