class User {
  int? id;
  String name;
  String email;
  String phone;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
  });

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
    );
  }
  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'name': name,
      'email': email,
      'phone': phone,
    };
    if (id != null) {
      map['id'] = id;
    }

    return map;
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['phone'] = phone;
    if (id != null) {
      data['id'] = id;
    }
    return data;
  }
}
