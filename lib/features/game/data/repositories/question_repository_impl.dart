import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_remote_datasource.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl extends QuestionRepository {
  QuestionLocalDatasource localDatasource;
  QuestionRemoteDatasource remoteDatasource;

  QuestionRepositoryImpl({required this.localDatasource, required this.remoteDatasource});

  @override
  Future<Question> getNextQuestion(String langCode) {
    return localDatasource.getNextQuestion(langCode);
  }

  @override
  Future<void> putQuestion(Question question) {
    return localDatasource.putQuestion(question);
  }

  @override
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to) {
    return remoteDatasource.getQuestionsBundle(langCode, from, to);
  }
}
