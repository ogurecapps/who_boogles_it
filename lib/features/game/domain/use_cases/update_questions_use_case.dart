import 'package:who_boogles_it/core/util/logger.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class UpdateQuestionsUseCase {
  final QuestionRepository repository;

  UpdateQuestionsUseCase({required this.repository});

  Future<void> execute(String langCode) async {
    var pageSize = 10;
    var from = 0;
    var to = from + pageSize - 1;
    var data = await repository.getQuestionsBundle(langCode, from, to);
    Logger.print('Rows received: ${data.length.toString()}');

    for (var i = 0; i < data.length; i++) {
      Logger.print(data[i].toString());
    }
  }
}
