import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/core/util/analytics_engine.dart';
import 'package:who_boogles_it/core/util/performance_trace.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource.dart';

class QuestionLocalDatasourceImpl extends QuestionLocalDatasource {
  LocalDatabase db;

  QuestionLocalDatasourceImpl({required this.db});

  @override
  Future<Question> getNextQuestion(String langCode) async {
    final PerformanceTrace trace = PerformanceTrace(traceName: 'get-next-question-trace');

    var question =
        await db.getDb().questions.where().langCodeEqualTo(langCode).sortByLastPlayed().findFirst();

    if (question == null) {
      trace.stop(attributes: {'found': 'false'});
      AnalyticsEngine.logEvent(name: 'No questions found', parameters: {'langCode': langCode});

      throw Exception('No questions found');
    } else {
      // Mark as played
      question.lastPlayed = DateTime.now();
      await putQuestion(question);
    }

    trace.stop(attributes: {'found': 'true'});
    return question;
  }

  @override
  Future<void> putQuestion(Question question) async {
    await db.getDb().writeTxn(() async {
      await db.getDb().questions.put(question);
    });
  }
}
