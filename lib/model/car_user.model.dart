class CarUser {
  int? id;
  String name;
  String email;
  String phone;
  int carId;

  CarUser({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.carId,
  });

  factory CarUser.fromMap(Map<String, dynamic> map) {
    return CarUser(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      carId: map['carId'],
    );
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
      'carId': carId,
    };
    if (id != 0) {
      map['id'] = id;
    }

    return map;
  }

  factory CarUser.fromJson(Map<String, dynamic> json) {
    return CarUser(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      carId: json['carId'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    data['carId'] = carId;
    if (id != 0) {
      data['id'] = id;
    }
    return data;
  }

  @override
  String toString() {
    return '{id: $id, name: $name, email: $email, phone: $phone, carId: $carId}';
  }
}
