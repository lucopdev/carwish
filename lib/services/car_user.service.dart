import 'package:cars/database/database_config.dart';
import 'package:cars/model/car_user.model.dart';

class CarUserService {
  Future<void> insertCarUser(CarUser user) async {
    final db = await DatabaseHelper().database;
    await db.insert('carUsers', user.toJson());
  }

  Future<List<CarUser>> getCarUsers() async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> maps = await db.query('carUsers');
    return List.generate(maps.length, (index) => CarUser.fromMap(maps[index]));
  }

  Future<int> deleteCarUser(int id) async {
    final db = await DatabaseHelper().database;
    try {
      return await db.delete(
        'carUsers',
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      return 0;
    }
  }
}
