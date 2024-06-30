import 'package:cars/common/app_routes.dart';
import 'package:cars/common/my_colors.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: MyColors.textTheme,
        surfaceTintColor: MyColors.textTheme,
        elevation: 16,
        shape: const RoundedRectangleBorder(),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              right: BorderSide(
                color: MyColors.drawerTheme,
                width: 5,
              ),
            ),
          ),
          child: Column(
            children: [
              AppBar(
                flexibleSpace: Image.asset(
                  'assets/images/drawerbg.jpg',
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                backgroundColor: MyColors.drawerTheme,
                automaticallyImplyLeading: false,
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.home),
                title: Text('Início',
                    style: Theme.of(context).textTheme.headlineMedium),
                onTap: () {
                  Navigator.of(context).pushReplacementNamed(AppRoutes.HOME);
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.info_outline_rounded),
                title: Text(
                  'Sobre nós',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                onTap: () => Navigator.of(context).pushNamed(AppRoutes.ABOUT),
              ),
              const SizedBox(
                height: 20,
              ),
              ListTile(
                leading: const Icon(Icons.developer_board),
                title: Text(
                  'DEV AREA',
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                onTap: () =>
                    Navigator.of(context).pushNamed(AppRoutes.DEV_AREA),
              ),
            ],
          ),
        ));
  }
}
