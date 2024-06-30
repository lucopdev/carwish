import 'package:cars/services/car_user.service.dart';
import 'package:workmanager/workmanager.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

@pragma('vm:entry-point')
void schedulePeriodicTask() {
  Workmanager().registerPeriodicTask(
    'taskOne',
    'postDataTask',
    frequency: const Duration(days: 5),
  );
}

@pragma('vm:entry-point')
void scheduleOneOffTask() {
  Workmanager().registerOneOffTask(
    'taskTwo',
    'postDataTask',
    initialDelay: const Duration(seconds: 10),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((postDataTask, inputData) async {
    print('Posting data... >>>>>>>>>>>>>>>>>>>>>>>>>>>');
    return await postData().then((value) => value['body']);
  });
}

Future<Map<String, dynamic>> postData() async {
  const url = 'https://www.wswork.com.br/cars/leads/';

  try {
    final users = await CarUserService().getCarUsers();
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      },
      body: jsonEncode({'users': users.map((user) => user.toJson()).toList()}),
    );

    if (response.statusCode == 200) {
      print('POST request successful');
      print('Response body: ${response.body}');
      return {
        'message': 'SUCCESS',
        'code': response.statusCode,
        'body': response.body
      };
    } else {
      print('Failed to post data: ${response.statusCode}');
      print('Response body: ${response.body}');
      return {
        'message': 'FAILED',
        'code': response.statusCode,
        'body': response.body
      };
    }
  } catch (e) {
    print('Error: $e');
    return {'message': 'FAILED', 'code': 500, 'body': e.toString()};
  }
}
