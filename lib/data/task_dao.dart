import 'package:flutter_organizer/components/task.dart';
import 'package:flutter_organizer/data/database.dart';
import 'package:sqflite/sqflite.dart';

class TaskDao {
  static const String tableSql = 'CREATE TABLE $_tableName('
      '$_title TEXT, '
      '$_rating INTEGER, '
      '$_image TEXT, '
      '$_day INTEGER)';

  static const String _tableName = 'tasks';
  static const String _title = 'title';
  static const String _rating = 'rating';
  static const String _image = 'image';
  static const String _day = 'day';

  save(Task task) async {
    final Database db = await getDatabase();
    var itemExists = await find(task.title);
    Map<String, dynamic> taskMap = _toMap(task);
    if (itemExists.isEmpty) {
      return await db.insert(_tableName, taskMap);
    } else {
      return await db.update(_tableName, taskMap,
          where: '$_title = ?', whereArgs: [task.title]);
    }
  }

  Future<List<Task>> findAll() async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result = await db.query(_tableName);
    return _toList(result);
  }

  Future<List<Task>> find(String taskName) async {
    final Database db = await getDatabase();
    final List<Map<String, dynamic>> result =
        await db.query(_tableName, where: '$_title = ?', whereArgs: [taskName]);
    return _toList(result);
  }

  delete(String taskName) async {
    final Database db = await getDatabase();
    return await db
        .delete(_tableName, where: '$_title = ?', whereArgs: [taskName]);
  }

  List<Task> _toList(List<Map<String, dynamic>> taskList) {
    final List<Task> tasks = [];
    for (Map<String, dynamic> row in taskList) {
      final Task task = Task(row[_title], row[_rating], row[_image], row[_day]);
      tasks.add(task);
    }
    return tasks;
  }

  Map<String, dynamic> _toMap(Task task) {
    final Map<String, dynamic> taskMap = {};
    taskMap[_title] = task.title;
    taskMap[_rating] = task.rating;
    taskMap[_image] = task.image;
    taskMap[_day] = task.day;
    return taskMap;
  }
  
}