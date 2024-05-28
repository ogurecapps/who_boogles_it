import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class PublishAnswerUseCase {
  final QuestionRepository repository;

  PublishAnswerUseCase({required this.repository});

  Future<void> execute(int questionId, String answer) async {
    await repository.pubAnswer(questionId, answer);
  }
}
