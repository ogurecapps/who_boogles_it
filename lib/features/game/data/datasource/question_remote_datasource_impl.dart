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
}
