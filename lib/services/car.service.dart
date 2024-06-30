// api_service.dart
import 'package:cars/model/car.model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<List<Car>> fetchCars() async {
  final response = await http.get(Uri.parse('https://wswork.com.br/cars.json'));

  if (response.statusCode == 200) {
    final jsonData = json.decode(response.body);
    final List<dynamic> carsJson = jsonData['cars'];
    return carsJson.map((json) => Car.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load data');
  }
}
