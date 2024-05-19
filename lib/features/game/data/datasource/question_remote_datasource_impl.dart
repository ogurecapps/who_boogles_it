import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:who_boogles_it/features/game/data/datasource/question_remote_datasource.dart';

class QuestionRemoteDatasourceImpl extends QuestionRemoteDatasource {
  final db = Supabase.instance.client;

  @override
  Future<List<Map<String, dynamic>>> getQuestionsBundle(String langCode, int from, int to) async {
    return await db.from('questions').select().eq('language', langCode).range(from, to);
  }
}
