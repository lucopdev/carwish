import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p; // Importando 'path' com o prefixo 'p'

class DatabaseHelper {
  static Database? _database;
  static const String _dbName = 'cars_database.db';

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  Future<Database> initDatabase() async {
    var documentsDirectory = await getApplicationDocumentsDirectory();
    var dbPath = p.join(documentsDirectory.path, _dbName);

    return await openDatabase(dbPath, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute('''
        CREATE TABLE users(
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name VARCHAR(50),
          phone VARCHAR(11),
          email VARCHAR(50)
        )
      ''');
    });
  }
}
