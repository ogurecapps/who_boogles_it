import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:who_boogles_it/core/util/logger.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_remote_datasource.dart';

class QuestionRemoteDatasourceImpl extends QuestionRemoteDatasource {
  final db = Supabase.instance.client;

  @override
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to) async {
    List<Map<String, dynamic>> data = [];

    try {
      data = await db.from('questions').select().eq('language', langCode).range(from, to);
    } catch (e) {
      Logger.print('Error obtaining the data: ${e.toString()}', level: 'WARN');
    }

    return data;
  }

  @override
  Future<void> pubAnswer(int questionId, String answer) async {
    try {
      var data = await db.from('answers').select().eq('text', '$questionId#$answer').maybeSingle();
      if (data == null || data.isEmpty) {
        await db.from('answers').insert({'text': '$questionId#$answer'});
        Logger.print('Publish new answer: "$questionId#$answer"');
      }
    } catch (e) {
      Logger.print('Error on publish answer: ${e.toString()}', level: 'WARN');
    }
  }
}
