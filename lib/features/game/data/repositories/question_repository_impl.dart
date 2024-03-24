import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class QuestionRepositoryImpl extends QuestionRepository {
  QuestionLocalDatasource localDatasource;

  QuestionRepositoryImpl({required this.localDatasource});

  @override
  Future<Question> getNextQuestion(String langCode) {
    return localDatasource.getNextQuestion(langCode);
  }

  @override
  Future<void> putQuestion(Question question) {
    return localDatasource.putQuestion(question);
  }
}
