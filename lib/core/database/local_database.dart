import 'package:isar/isar.dart';

abstract class LocalDatabase {
  Future<void> initDb();
  Isar getDb();
  Future<void> cleanDb();
}
