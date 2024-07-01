import 'package:cars/model/car.model.dart';
import 'package:cars/model/user.model.dart';

class CarUser {
  final int id;
  final int timestampCadastro;
  final User user;
  final Car car;

  CarUser({
    required this.id,
    required this.timestampCadastro,
    required this.user,
    required this.car,
  });

  factory CarUser.fromJson(Map<String, dynamic> json) {
    return CarUser(
      id: json['id'] as int,
      timestampCadastro: json['timestampCadastro'] as int,
      user: User.fromJson({
        'id': json['userId'] as int,
        'name': json['userName'] as String,
        'phone': json['userPhone'] as String,
        'email': json['userEmail'] as String,
      }),
      car: Car.fromJson(json['car']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'timestampCadastro': timestampCadastro,
      'userId': user.id,
      'userName': user.name,
      'userPhone': user.phone,
      'userEmail': user.email,
      'car': car.toJson(),
    };
  }

  factory CarUser.fromMap(Map<String, dynamic> map) {
    return CarUser(
      id: map['id'] as int,
      timestampCadastro: map['timestampCadastro'] as int,
      user: User(
        id: map['userId'] as int,
        name: map['userName'] as String,
        phone: map['userPhone'] as String,
        email: map['userEmail'] as String,
      ),
      car: Car.fromMap(map['car'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'timestampCadastro': timestampCadastro,
      'userName': user.name,
      'userPhone': user.phone,
      'userEmail': user.email,
      'carId': car.id,
    };
  }
}
