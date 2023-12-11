import 'package:personal_tasks/Models/task.dart';
import 'package:personal_tasks/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableName = "tasks";
  static const String name = 'name';
  static const String difficultyLevel = 'difficult_level';
  static const String imageUrl = 'image_url';

  static const String tableSql = "CREATE TABLE $tableName("
      "id INTEGER PRIMARY KEY AUTOINCREMENT, "
      "$name TEXT, "
      "$difficultyLevel INTEGER, "
      "$imageUrl TEXT)";

  save(Task task) async {
    final Database db = await getDatabase();
    db.insert(tableName, toMap(task));
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(tableName);
    return toList(result);
  }

  List<Task> toList(List<Map<String, dynamic>> taskMap){
    final List<Task> tasks = [];
    for(Map<String, dynamic> taskRow in taskMap){
      final Task task = Task(
          id: taskRow["id"],
          name: taskRow[name],
          difficultyLevel: taskRow[difficultyLevel],
          imageUrl: taskRow[imageUrl]);
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> toMap(Task task)
  {
    final Map<String, dynamic> taskMap = {};
    taskMap[name] = task.name;
    taskMap[difficultyLevel] = task.difficultyLevel;
    taskMap[imageUrl] = task.imageUrl;
    return taskMap;
  }

  Future<Task?> findOne(int id) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(tableName, where: "id=?", whereArgs: [id]);
    if(result.isNotEmpty){
      return toList(result).first;
    }
    return null;
  }

  Future<bool> updateOne(int id, Task task) async {
    final Database db = await getDatabase();
    int rowsAffected = await db.update(tableName, toMap(task), where: "id=?", whereArgs: [id]);
    return rowsAffected > 0;
  }

  Future<bool> deleteOne(int id) async {
    final Database db = await getDatabase();
    int rowsAffected = await db.delete(tableName, where: "id=?", whereArgs: [id]);
    return rowsAffected > 0;
  }
}