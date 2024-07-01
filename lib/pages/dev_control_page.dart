import 'dart:convert';

import 'package:cars/common/my_colors.dart';
import 'package:cars/common/task_manager.dart';
import 'package:cars/model/car_user.model.dart';
import 'package:cars/services/car_user.service.dart';
import 'package:cars/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:cars/database/database_config.dart';
import 'package:http/http.dart' as http;

@pragma(
    'vm:entry-point') // Mandatory if the App is obfuscated or using Flutter 3.1+
class DevControlPage extends StatefulWidget {
  const DevControlPage({super.key});

  @override
  State<DevControlPage> createState() => _DevControlPageState();
}

class _DevControlPageState extends State<DevControlPage> {
  final _idController = TextEditingController();
  List<CarUser> carusers = [];

  void _showData() async {
    try {
      final List<CarUser> data = await CarUserService().getCarUsers();
      setState(() {
        carusers = data;
      });
    } catch (e) {
      print('Erro ao obter usuários: $e');
    }
  }

  void _deleteCarUser() {
    final idText = _idController.text.trim();
    if (idText.isEmpty) return;

    final id = int.tryParse(idText);
    if (id == null) {
      print('ID inválido');
      return;
    }

    CarUserService().deleteCarUser(id).then((value) {
      if (value > 0) {
        _showData();
        _idController.clear();
      } else {
        print('Erro ao deletar usuário.');
      }
    }).catchError((error) {
      print('Erro ao deletar usuário: $error');
    });
  }

  Future<void> _resetDatabase() async {
    await DatabaseHelper().resetDatabase();
    setState(() {
      carusers = [];
    });
  }

  Future<Map<String, dynamic>> _postData() async {
    // const url = 'https://www.wswork.com.br/cars/leads';
    const url = 'http://10.0.0.106:50000/lucopdev/api';

    const headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json',
    };

    try {
      final caruser = await CarUserService().getCarUsers();

      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(
            {'users': caruser.map((user) => user.toJson()).toList()}),
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

  // Future<Map<String, dynamic>> _postData() async {
  //   const url = 'https://www.wswork.com.br/cars/leads/';
  //   const headers = {
  //     'Content-Type': 'application/json; charset=UTF-8',
  //     'Accept': 'application/json',
  //   };

  //   try {
  //     final users = await CarUserService().getCarUsers();
  //     var parameters = {'user': users.map((user) => user.toJson()).toList()};

  //     final response = await http.get(
  //       Uri.parse('$url?user=${Uri.encodeComponent(jsonEncode(parameters))}'),
  //       headers: headers,
  //       // body:
  //       //     jsonEncode({'users': users.map((user) => user.toJson()).toList()}),
  //     );

  //     if (response.statusCode == 200) {
  //       return {
  //         'message': 'SUCCESS',
  //         'code': response.statusCode,
  //         'body': response.body
  //       };
  //     } else {
  //       if (response.headers.containsKey('location') &&
  //           (response.statusCode == 301 || response.statusCode == 302)) {
  //         var redirectResponse =
  //             await http.get(Uri.parse(response.headers['location']!));

  //         return {
  //           'message': 'SUCCESS',
  //           'code': redirectResponse.statusCode,
  //           'body': redirectResponse.body,
  //         };
  //       }

  //       return {
  //         'message': 'FAILED',
  //         'code': response.statusCode,
  //         'body': response.body
  //       };
  //     }
  //   } catch (e) {
  //     return {'message': 'FAILED', 'code': 500, 'body': e.toString()};
  //   }
  // }

  void _runTask() {
    scheduleOneOffTask();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
        context: context,
        title: 'Dev Area',
        showBackButton: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            const Text('Area de dev, não existe em produção'),
            const SizedBox(height: 50),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.drawerTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(200, 50),
                          ),
                          onPressed: _showData,
                          child: Text(
                            'Show data',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.drawerTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(200, 50),
                          ),
                          onPressed: _runTask,
                          child: Text(
                            'Run task',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.drawerTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(150, 50),
                          ),
                          onPressed: _deleteCarUser,
                          child: Text(
                            'Delete user',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: TextField(
                          controller: _idController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 12,
                            ),
                            hintText: 'ID',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius
                                  .zero, // Sem arredondamento nos cantos
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.drawerTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(150, 50),
                            maximumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: _resetDatabase,
                          child: Text(
                            'Reset Data',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: MyColors.drawerTheme,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            minimumSize: const Size(150, 50),
                            maximumSize: const Size(double.infinity, 50),
                          ),
                          onPressed: _postData,
                          child: Text(
                            'Post Data',
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(top: 20),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: MyColors.drawerTheme,
                    width: 1,
                  ),
                ),
                child: SingleChildScrollView(
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: carusers.length,
                    itemBuilder: (context, index) {
                      final caruser = carusers[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.drawerTheme,
                              width: 1,
                            ),
                          ),
                          child: Container(
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'ID:',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineMedium,
                                    ),
                                    Text(
                                      caruser.id.toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall,
                                    ),
                                  ],
                                ),
                                ListTile(
                                  title: Text(
                                    caruser.car.nomeModelo,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  subtitle: Text(
                                    caruser.car.cor,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  trailing: Text(
                                    caruser.car.ano.toString(),
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    caruser.user.name,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                  subtitle: Text(
                                    caruser.user.email,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                                ListTile(
                                  title: Text(
                                    caruser.user.phone,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
