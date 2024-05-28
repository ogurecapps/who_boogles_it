abstract class QuestionRemoteDatasource {
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to);
  Future<void> pubAnswer(int questionId, String answer);
}
