import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class GetQuestionUseCase {
  final QuestionRepository repository;

  GetQuestionUseCase({required this.repository});

  Future<Question> execute(String langCode) {
    return repository.getNextQuestion(langCode);
  }
}
