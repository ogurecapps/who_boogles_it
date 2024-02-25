import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:who_boogles_it/core/database/local_database.dart';
import 'package:who_boogles_it/models/player.dart';
import 'package:who_boogles_it/models/question.dart';

class LocalDatabaseImpl extends LocalDatabase {
  late Isar _db;

  @override
  Future<void> cleanDb() async {
    await _db.writeTxn(() => _db.clear());
  }

  @override
  Isar getDb() {
    return _db;
  }

  @override
  Future<void> initDb() async {
    if (Isar.instanceNames.isEmpty) {
      final dir = await getApplicationDocumentsDirectory();
      _db = await Isar.open([PlayerSchema, QuestionSchema], directory: dir.path);
    } else {
      _db = Isar.getInstance()!;
    }
  }
}
