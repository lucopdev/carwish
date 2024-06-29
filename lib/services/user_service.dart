import 'package:cars/database/database_config.dart';
import 'package:cars/model/user.model.dart';

class UserService {
  Future<void> insertUser(User user) async {
    final db = await DatabaseHelper().database;
    await db.insert('users', user.toJson());
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await DatabaseHelper().database;
    return await db.query('users');
  }

  Future<int> deleteUser(int id) async {
    final db = await DatabaseHelper().database;
    try {
      return await db.delete(
        'users',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      return 0;
    }
  }
}
