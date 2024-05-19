import 'package:isar/isar.dart';

part 'question.g.dart';

@collection
class Question {
  Id id;
  String text;
  List<String> rightAnswers;
  List<String> wrongAnswers;
  @Index()
  DateTime? lastPlayed;
  @Index()
  String langCode;

  Question({
    required this.id,
    required this.text,
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.langCode,
  });
}
