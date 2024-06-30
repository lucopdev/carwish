import 'package:cars/common/my_colors.dart';
import 'package:cars/model/car_user.model.dart';
import 'package:cars/services/car_user_service.dart';
import 'package:cars/widget/app_bar_custom.dart';
import 'package:flutter/material.dart';
import 'package:cars/database/database_config.dart';

class DevControlPage extends StatefulWidget {
  const DevControlPage({super.key});

  @override
  State<DevControlPage> createState() => _DevControlPageState();
}

class _DevControlPageState extends State<DevControlPage> {
  final _idController = TextEditingController();
  List<CarUser> users = [];

  void _showData() async {
    try {
      final List<CarUser> data = await CarUserService().getUsers();
      setState(() {
        users = data;
      });
    } catch (e) {
      print('Erro ao obter usuários: $e');
    }
  }

  void _deleteUser() {
    final idText = _idController.text.trim();
    if (idText.isEmpty) return;

    final id = int.tryParse(idText);
    if (id == null) {
      print('ID inválido');
      return;
    }

    CarUserService().deleteUser(id).then((value) {
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
      users = [];
    });
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
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.drawerTheme,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: _showData,
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
                      onPressed: _deleteUser,
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
                const SizedBox(height: 15),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: MyColors.drawerTheme,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  onPressed: _resetDatabase,
                  child: Text(
                    'Resetar Banco de Dados',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
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
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      final user = users[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: MyColors.drawerTheme,
                              width: 1,
                            ),
                          ),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(10),
                            title: Text(user.name),
                            leading: Text(user.id.toString(),
                                style:
                                    Theme.of(context).textTheme.headlineMedium),
                            subtitle: Text(user.email),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(user.phone),
                                Text('Id do carro: ${user.carId.toString()}'),
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
