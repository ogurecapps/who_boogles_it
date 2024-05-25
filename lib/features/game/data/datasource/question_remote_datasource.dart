abstract class QuestionRemoteDatasource {
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to);
}
