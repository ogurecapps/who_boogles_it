import 'package:who_boogles_it/core/models/question.dart';

abstract class QuestionLocalDatasource {
  Future<Question> getNextQuestion(String langCode);
  Future<void> putQuestion(Question question);
}
