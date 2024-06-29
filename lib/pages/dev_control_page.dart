import 'package:cars/common/my_colors.dart';
import 'package:cars/services/user_service.dart';
import 'package:cars/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';

class DevControlPage extends StatefulWidget {
  const DevControlPage({super.key});

  @override
  State<DevControlPage> createState() => _DevControlPageState();
}

class _DevControlPageState extends State<DevControlPage> {
  final _idController = TextEditingController();

  void _showData() {
    UserService().getUsers().then((value) {
      print('Dados Salvos:');
      print(value);
    });
  }

  void _deleteUser() {
    final idText = _idController.text.trim();
    if (idText.isEmpty) return;

    final id = int.parse(idText);
    UserService().deleteUser(id).then((value) {
      print('Usuário deletado:');
      print(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildCustomAppBar(
          context: context, title: 'Dev Area', showBackButton: true),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Center(
          child: Column(
            children: [
              const Text('Dev Area'),
              const SizedBox(height: 50),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: MyColors.drawerTheme,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                      minimumSize: const Size(200, 50),
                    ),
                    onPressed: () => _showData(),
                    child: Text(
                      'Ver dados',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.drawerTheme,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero,
                          ),
                          minimumSize: const Size(200, 50),
                        ),
                        onPressed: () => _deleteUser(),
                        child: Text(
                          'Deletar usuário',
                          style: Theme.of(context).textTheme.headlineMedium,
                        ),
                      ),
                      SizedBox(
                        width: 80,
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
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
