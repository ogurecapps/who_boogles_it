import 'package:isar/isar.dart';

part 'question.g.dart';

@collection
class Question {
  Id id = Isar.autoIncrement;
  @Index(unique: true, replace: true)
  int questionId;
  String text;
  List<String> rightAnswers;
  List<String> wrongAnswers;
  @Index()
  DateTime? lastPlayed;
  @Index()
  String langCode;

  Question({
    required this.questionId,
    required this.text,
    required this.rightAnswers,
    required this.wrongAnswers,
    required this.langCode,
  });

  static Question fromMap(Map<String, dynamic> data) {
    return Question(
      questionId: data['id'],
      text: data['text'],
      rightAnswers: List<String>.from(data['right']),
      wrongAnswers: List<String>.from(data['wrong']),
      langCode: data['language'],
    );
  }
}
