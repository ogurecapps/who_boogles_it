import 'package:isar/isar.dart';

part 'question.g.dart';

@collection
class Question {
  Id isarId = Isar.autoIncrement;
  String text;
  List<String> rightAnswers; // Fixed size collection (Set unsupported)
  List<String> wrongAnswers; // Need limit
  @Index()
  DateTime? lastPlayed;
  @Index()
  String langCode;

  Question(
      {required this.text, required this.rightAnswers, required this.wrongAnswers, required this.langCode});
}
