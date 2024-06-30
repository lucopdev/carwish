import 'package:cars/model/car_user.model.dart';
import 'package:cars/services/car_user_service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void schedulePeriodicTask() {
  Workmanager().initialize(callbackDispatcher);
  Workmanager().registerPeriodicTask(
    initialDelay: const Duration(minutes: 15),
    'postDataTask',
    'simplePeriodicTask',
    frequency: const Duration(minutes: 15),
  );
}

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    final carUserService = CarUserService();
    final users = await carUserService.getUsers();

    if (users.isNotEmpty) {
      await postData(users);
    } else {
      print('No users found in the database.');
    }
    return Future.value(true);
  });
}

Future<void> postData(List<CarUser> users) async {
  const url = 'https://www.wswork.com.br/cars/leads/';

  try {
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'users': users.map((user) => user.toJson()).toList()}),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
    } else {
      print('Failed to post data: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}
