import 'package:cars/database/database_config.dart';
import 'package:cars/model/car_user.model.dart';
import 'package:cars/model/car.model.dart';
import 'package:cars/model/user.model.dart';
import 'package:sqflite/sqflite.dart';

class CarUserService {
  Future<void> insertCarUser(CarUser carUser) async {
    final db = await DatabaseHelper().database;

    await db.insert(
      'cars',
      carUser.car.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    await db.insert(
      'carUsers',
      {
        'id': carUser.id,
        'timestampCadastro': carUser.timestampCadastro,
        'userId': carUser.user.id,
        'userName': carUser.user.name,
        'userPhone': carUser.user.phone,
        'userEmail': carUser.user.email,
        'carId': carUser.car.id,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<CarUser>> getCarUsers() async {
    final db = await DatabaseHelper().database;

    // Obtém todos os registros da tabela carUsers
    final List<Map<String, dynamic>> carUserMaps = await db.query('carUsers');

    return Future.wait(
      carUserMaps.map((map) async {
        // Obtém o Car associado a cada CarUser
        final car = await getCarById(map['carId'] as int);
        return CarUser(
          id: map['id'] as int,
          timestampCadastro: map['timestampCadastro'] as int,
          user: User(
            id: map['userId'] as int,
            name: map['userName'] as String,
            phone: map['userPhone'] as String,
            email: map['userEmail'] as String,
          ),
          car: car,
        );
      }).toList(),
    );
  }

  Future<Car> getCarById(int carId) async {
    final db = await DatabaseHelper().database;
    final List<Map<String, dynamic>> carMaps = await db.query(
      'cars',
      where: 'id = ?',
      whereArgs: [carId],
    );

    if (carMaps.isNotEmpty) {
      return Car.fromMap(carMaps.first);
    } else {
      throw Exception('Car not found');
    }
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
