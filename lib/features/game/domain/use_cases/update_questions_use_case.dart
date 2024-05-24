import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/core/util/logger.dart';
import 'package:who_boogles_it/core/util/performance_trace.dart';
import 'package:who_boogles_it/features/game/domain/repositories/question_repository.dart';

class UpdateQuestionsUseCase {
  final QuestionRepository repository;

  UpdateQuestionsUseCase({required this.repository});

  Future<void> execute(String langCode) async {
    List<Map<String, dynamic>> data;

    int pageSize = 3;
    int pageNumber = 0;
    int from = 0;
    int to;

    PerformanceTrace trace;

    do {
      pageNumber++;
      to = from + pageSize - 1;
      trace = PerformanceTrace(traceName: 'get-questions-bundle-trace');

      await trace.start();
      data = await repository.getQuestionsBundle(langCode, from, to);
      await trace.stop(attributes: {'pageNumber': pageNumber.toString(), 'pageSize': pageSize.toString()});
      Logger.print('Questions update. ${data.isEmpty ? 'Done!' : 'Page: $pageNumber'}');

      await writeBundle(data);
      from = to + 1;
    } while (data.isNotEmpty);
  }

  Future<void> writeBundle(List<Map<String, dynamic>> data) async {
    Question question;
    for (var i = 0; i < data.length; i++) {
      question = Question.fromMap(data[i]);
      Logger.print('Writing question: "${question.text}"');
      await repository.putQuestion(question);
    }
  }
}
