import 'package:cars/widget/app_bar_custom.dart';
import 'package:cars/widget/app_drawer.dart';
import 'package:flutter/material.dart';

class PageNotFound extends StatelessWidget {
  const PageNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar:
          buildCustomAppBar(context: context, title: 'Pagina não encontrada'),
      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 50),
            Text('Ops! A página que você buscou não existe no nosso sistema :(',
                style: Theme.of(context).textTheme.headlineSmall,
                textAlign: TextAlign.center),
            const SizedBox(height: 10),
            Text('Desculpe pelo transtorno!',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 50),
            Image.asset('assets/images/not_found.png', width: 200, height: 200)
          ],
        ),
      ),
    );
  }
}
