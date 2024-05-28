import 'package:who_boogles_it/core/models/question.dart';

abstract class QuestionRepository {
  Future<Question> getNextQuestion(String langCode);
  Future<void> putQuestion(Question question);
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to);
  Future<void> pubAnswer(int questionId, String answer);
}
