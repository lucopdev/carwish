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
    constraints: Constraints(
      networkType: NetworkType.not_required,
      // other constraints can be added here
    ),
  );
}

@pragma('vm:entry-point')
void scheduleOneOffTask() {
  Workmanager().registerOneOffTask(
    'taskTwo',
    'postDataTask',
    initialDelay: const Duration(seconds: 5),
  );
}

@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((postDataTask, inputData) async {
    print('Posting data... >>>>>>>>>>>>>>>>>>>>>>>>>>>');
    await postData();
    return Future.value(true);
  });
}

Future<Map<String, dynamic>> postData() async {
  const url = 'https://www.wswork.com.br/cars/leads';
  // const url = 'http://10.0.0.106:50000/lucopdev/api';
  const headers = {
    'Content-Type': 'application/json; charset=UTF-8',
    'Accept': 'application/json',
  };

  print(url);
  try {
    final users = await CarUserService().getCarUsers();

    final response = await http.post(
      Uri.parse(url),
      headers: headers,
      body: jsonEncode({'users': users.map((user) => user.toJson()).toList()}),
    );

    if (response.statusCode == 200) {
      return {
        'message': 'SUCCESS',
        'code': response.statusCode,
        'body': response.body
      };
    } else {
      if (response.headers.containsKey('location') &&
          (response.statusCode == 301 || response.statusCode == 302)) {
        print(response.body);
        var redirectResponse =
            await http.get(Uri.parse(response.headers['location']!));

        print(redirectResponse.body);
        return {
          'message': 'SUCCESS',
          'code': redirectResponse.statusCode,
          'body': redirectResponse.body,
        };
      }

      return {
        'message': 'FAILED',
        'code': response.statusCode,
        'body': response.body
      };
    }
  } catch (e) {
    return {'message': 'FAILED', 'code': 500, 'body': e.toString()};
  }
}
