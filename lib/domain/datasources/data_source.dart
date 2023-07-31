import 'package:sqflite/sqflite.dart';
import 'package:tareas/domain/models/news_model.dart';

class TaskDataSource {

  
  Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database;
    _database = await createDatabase();
    return _database;
  }

  Future createDatabase() async {
    return openDatabase(
      'my_database.db', // Cambia 'my_database.db' por el nombre que desees para la base de datos
      version: 1,
      onCreate: (Database database, int version) async {
        await database.execute(
          "CREATE TABLE article ("
          "id INTEGER PRIMARY KEY,"
          "author TEXT, "
          "title TEXT,"
          "description TEXT,"
          "url TEXT,"
          "urlToImage TEXT"
          ")",
        );
      },
    );
  }

  Future<List<Article>> getAllTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db!.query('article');
    return List.generate(
      maps.length,
      (i) => Article(
          author: maps[i]['author'],
          title: maps[i]['title'],
          description: maps[i]['description'],
          url: maps[i]['url'],
          urlToImage: maps[i]['urlToImage']),
    );
  }

  Future<void> addTask(Article article) async {
    final db = await database;
    await db!.insert('article', article.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
