import 'package:isar/isar.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/core/models/question.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_local_datasource.dart';

class QuestionLocalDatasourceImpl extends QuestionLocalDatasource {
  LocalDatabase db;

  QuestionLocalDatasourceImpl({required this.db});

  @override
  Future<Question> getNextQuestion(String langCode) async {
    var question =
        await db.getDb().questions.where().langCodeEqualTo(langCode).sortByLastPlayed().findFirst();

    if (question == null) {
      throw Exception('No questions found');
    } else {
      // Mark as played
      question.lastPlayed = DateTime.now();
      await putQuestion(question);
    }

    return question;
  }

  @override
  Future<void> putQuestion(Question question) async {
    await db.getDb().writeTxn(() async {
      await db.getDb().questions.put(question);
    });
  }
}
