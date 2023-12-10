import 'package:personal_tasks/data/task_dao.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

Future<Database> getDatabase() async {
  final String path = join(await getDatabasesPath(), "personal_tasks.db");
  return openDatabase(path, version: 1, onCreate: (db, version) {
    db.execute(TaskDao.tableSql);
  });
}


